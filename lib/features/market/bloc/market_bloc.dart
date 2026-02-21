import 'dart:async';

import '../../../core/domain/instrument.dart';
import '../../../core/domain/instrument_catalog.dart';
import '../../../core/domain/market_data.dart';
import '../../../core/domain/market_regime.dart';
import '../../../core/services/api_market_service.dart';

abstract class MarketEvent {}

class SwitchMarket extends MarketEvent {
  SwitchMarket(this.market);
  final MarketRegime market;
}

class LoadInstruments extends MarketEvent {}

class UpdatePrices extends MarketEvent {}

class AddToWatchlist extends MarketEvent {
  AddToWatchlist(this.symbol);
  final String symbol;
}

class RemoveFromWatchlist extends MarketEvent {
  RemoveFromWatchlist(this.symbol);
  final String symbol;
}

class RefreshMarketData extends MarketEvent {}

enum MarketStatus { loading, ready, error }

class MarketState {
  MarketState({
    required this.status,
    required this.activeMarket,
    required this.instruments,
    required this.snapshots,
    required this.watchlist,
    this.errorMessage,
  }) : indices = instruments
           .where((i) => i.type == InstrumentType.marketIndex)
           .toList(growable: false),
       tradableInstruments = instruments
           .where((i) => i.isTradable)
           .toList(growable: false);

  MarketState._cached({
    required this.status,
    required this.activeMarket,
    required this.instruments,
    required this.snapshots,
    required this.watchlist,
    required this.indices,
    required this.tradableInstruments,
    this.errorMessage,
  });

  final MarketStatus status;
  final MarketRegime activeMarket;
  final List<Instrument> instruments;
  final Map<String, MarketSnapshot> snapshots; // symbol → snapshot
  final Set<String> watchlist; // symbol set
  final String? errorMessage;

  final List<Instrument> indices;
  final List<Instrument> tradableInstruments;

  factory MarketState.initial() {
    return MarketState(
      status: MarketStatus.loading,
      activeMarket: MarketRegime.india,
      instruments: const [],
      snapshots: const {},
      watchlist: const {},
    );
  }

  MarketState copyWith({
    MarketStatus? status,
    MarketRegime? activeMarket,
    List<Instrument>? instruments,
    Map<String, MarketSnapshot>? snapshots,
    Set<String>? watchlist,
    String? errorMessage,
  }) {
    final newInstruments = instruments ?? this.instruments;
    final instrumentsChanged = instruments != null;

    return MarketState._cached(
      status: status ?? this.status,
      activeMarket: activeMarket ?? this.activeMarket,
      instruments: newInstruments,
      snapshots: snapshots ?? this.snapshots,
      watchlist: watchlist ?? this.watchlist,
      errorMessage: errorMessage,
      indices: instrumentsChanged
          ? newInstruments
                .where((i) => i.type == InstrumentType.marketIndex)
                .toList(growable: false)
          : indices,
      tradableInstruments: instrumentsChanged
          ? newInstruments.where((i) => i.isTradable).toList(growable: false)
          : tradableInstruments,
    );
  }

  MarketSnapshot? getSnapshot(String symbol) => snapshots[symbol];

  bool isInWatchlist(String symbol) => watchlist.contains(symbol);

  List<MarketSnapshot> get watchlistSnapshots {
    return watchlist
        .map((symbol) => snapshots[symbol])
        .whereType<MarketSnapshot>()
        .toList();
  }
}

class MarketBloc {
  static MarketBloc? _instance;

  factory MarketBloc({ApiMarketService? marketService}) {
    return _instance ??= MarketBloc._internal(
      marketService: marketService ?? ApiMarketService(),
    );
  }

  MarketBloc._internal({required ApiMarketService marketService})
    : _marketService = marketService {
    _init();
  }

  final ApiMarketService _marketService;
  final _stateController = StreamController<MarketState>.broadcast();
  final _eventController = StreamController<MarketEvent>();

  MarketState _state = MarketState.initial();
  StreamSubscription<PriceTick>? _tickSubscription;

  Stream<MarketState> get stream => _stateController.stream;
  MarketState get state => _state;

  void _init() {
    _eventController.stream.listen(_handleEvent);
    add(LoadInstruments());
  }

  void add(MarketEvent event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  void pause() {
    _tickSubscription?.pause();
  }

  void resume() {
    _tickSubscription?.resume();
  }

  void dispose() {
    _tickSubscription?.cancel();
    _marketService.dispose();
    _stateController.close();
    _eventController.close();
    _instance = null;
  }

  Future<void> _handleEvent(MarketEvent event) async {
    if (event is LoadInstruments) {
      await _handleLoadInstruments();
    } else if (event is SwitchMarket) {
      await _handleSwitchMarket(event.market);
    } else if (event is UpdatePrices) {
      await _handleUpdatePrices();
    } else if (event is AddToWatchlist) {
      _handleAddToWatchlist(event.symbol);
    } else if (event is RemoveFromWatchlist) {
      _handleRemoveFromWatchlist(event.symbol);
    } else if (event is RefreshMarketData) {
      await _handleRefreshMarketData();
    }
  }

  Future<void> _handleLoadInstruments() async {
    try {
      _emit(_state.copyWith(status: MarketStatus.loading));

      // 1. Fetch live pool from backend
      List<Instrument> instruments = await _marketService.getInstruments();

      // Filter by active market
      instruments = instruments
          .where((i) => i.market == _state.activeMarket)
          .toList();

      if (instruments.isEmpty) {
        // Fallback to active market from local catalog temporarily if backend is empty
        final indices = InstrumentCatalog.getIndices(_state.activeMarket);
        final stocks = InstrumentCatalog.getInstruments(_state.activeMarket);
        instruments = [...indices, ...stocks];
      }

      // 2. Fetch initial quotes for all
      final snapshots = <String, MarketSnapshot>{};
      await Future.wait(
        instruments.map((i) async {
          try {
            snapshots[i.symbol] = await _marketService.getQuote(i.symbol);
          } catch (e) {
            // Skip if backend fails for a single quote
          }
        }),
      );

      _emit(
        _state.copyWith(
          status: MarketStatus.ready,
          instruments: instruments,
          snapshots: snapshots,
        ),
      );

      // 3. Connect to WebSockets
      _setupTicks();
    } catch (e) {
      _emit(
        _state.copyWith(
          status: MarketStatus.error,
          errorMessage: 'Failed to load instruments: $e',
        ),
      );
    }
  }

  void _setupTicks() {
    _tickSubscription?.cancel();
    _tickSubscription = _marketService.streamTicks().listen((tick) {
      if (_state.status != MarketStatus.ready) return;

      final updated = Map<String, MarketSnapshot>.from(_state.snapshots);
      final old = updated[tick.symbol];

      if (old != null) {
        updated[tick.symbol] = old.copyWithPrice(
          price: tick.price,
          high: tick.price > old.high ? tick.price : old.high,
          low: tick.price < old.low ? tick.price : old.low,
          volume: tick.volume,
          timestamp: tick.timestamp,
        );
        _emit(_state.copyWith(snapshots: updated));
      }
    });
  }

  Future<void> _handleSwitchMarket(MarketRegime market) async {
    if (_state.activeMarket == market) return;

    _emit(_state.copyWith(activeMarket: market, watchlist: {}));
    await _handleLoadInstruments();
  }

  Future<void> _handleUpdatePrices() async {
    // Redundant when WebSockets are streaming, handled by stream listener!
  }

  void _handleAddToWatchlist(String symbol) {
    final newWatchlist = Set<String>.from(_state.watchlist)..add(symbol);
    _emit(_state.copyWith(watchlist: newWatchlist));
  }

  void _handleRemoveFromWatchlist(String symbol) {
    final newWatchlist = Set<String>.from(_state.watchlist)..remove(symbol);
    _emit(_state.copyWith(watchlist: newWatchlist));
  }

  Future<void> _handleRefreshMarketData() async {
    await _handleLoadInstruments();
  }

  void _emit(MarketState newState) {
    if (!_stateController.isClosed) {
      _state = newState;
      _stateController.add(_state);
    }
  }
}
