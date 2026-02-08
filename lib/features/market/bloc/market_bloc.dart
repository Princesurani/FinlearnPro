import 'dart:async';

import '../../../core/domain/instrument.dart';
import '../../../core/domain/instrument_catalog.dart';
import '../../../core/domain/market_data.dart';
import '../../../core/domain/market_regime.dart';
import '../../../core/services/market_service.dart';

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
  })  : indices = instruments
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

  factory MarketBloc({MarketService? marketService}) {
    return _instance ??= MarketBloc._internal(
      marketService: marketService ?? MarketService(),
    );
  }

  MarketBloc._internal({required MarketService marketService})
      : _marketService = marketService {
    _init();
  }

  final MarketService _marketService;
  final _stateController = StreamController<MarketState>.broadcast();
  final _eventController = StreamController<MarketEvent>();

  MarketState _state = MarketState.initial();
  Timer? _updateTimer;

  Stream<MarketState> get stream => _stateController.stream;
  MarketState get state => _state;


  void _init() {
    _eventController.stream.listen(_handleEvent);
    
    add(LoadInstruments());
    
    _updateTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => add(UpdatePrices()),
    );
  }


  void add(MarketEvent event) {
    _eventController.add(event);
  }

  void pause() {
    _updateTimer?.cancel();
    _updateTimer = null;
  }

  void resume() {
    if (_updateTimer != null) return; // Already running
    _updateTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => add(UpdatePrices()),
    );
  }

  void dispose() {
    _updateTimer?.cancel();
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

      final indices = InstrumentCatalog.getIndices(_state.activeMarket);
      final stocks = InstrumentCatalog.getInstruments(_state.activeMarket);
      final instruments = [...indices, ...stocks];

      final snapshots = <String, MarketSnapshot>{};
      for (final instrument in instruments) {
        final snapshot = _marketService.getCurrentSnapshot(instrument);
        snapshots[instrument.symbol] = snapshot;
      }

      _emit(_state.copyWith(
        status: MarketStatus.ready,
        instruments: instruments,
        snapshots: snapshots,
      ));
    } catch (e) {
      _emit(_state.copyWith(
        status: MarketStatus.error,
        errorMessage: 'Failed to load instruments: $e',
      ));
    }
  }

  Future<void> _handleSwitchMarket(MarketRegime market) async {
    if (_state.activeMarket == market) return; // No change

    try {
      _emit(_state.copyWith(status: MarketStatus.loading));

      final indices = InstrumentCatalog.getIndices(market);
      final stocks = InstrumentCatalog.getInstruments(market);
      final instruments = [...indices, ...stocks];

      final snapshots = <String, MarketSnapshot>{};
      for (final instrument in instruments) {
        final snapshot = _marketService.getCurrentSnapshot(instrument);
        snapshots[instrument.symbol] = snapshot;
      }

      _emit(_state.copyWith(
        status: MarketStatus.ready,
        activeMarket: market,
        instruments: instruments,
        snapshots: snapshots,
        watchlist: {}, // Clear watchlist on market switch
      ));
    } catch (e) {
      _emit(_state.copyWith(
        status: MarketStatus.error,
        errorMessage: 'Failed to switch market: $e',
      ));
    }
  }

  Future<void> _handleUpdatePrices() async {
    if (_state.status != MarketStatus.ready) return;

    try {
      final updatedSnapshots =
          Map<String, MarketSnapshot>.from(_state.snapshots);

      for (final instrument in _state.instruments) {
        final oldSnapshot = _state.snapshots[instrument.symbol];
        if (oldSnapshot == null) continue;

        final tick = _marketService.getQuickTick(instrument, oldSnapshot);

        updatedSnapshots[instrument.symbol] = oldSnapshot.copyWithPrice(
          price: tick.price,
          high: tick.price > oldSnapshot.high ? tick.price : oldSnapshot.high,
          low: tick.price < oldSnapshot.low ? tick.price : oldSnapshot.low,
          volume: tick.volume,
          timestamp: tick.timestamp,
        );
      }

      _emit(_state.copyWith(snapshots: updatedSnapshots));
    } catch (e) {
    }
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
    _state = newState;
    _stateController.add(_state);
  }
}
