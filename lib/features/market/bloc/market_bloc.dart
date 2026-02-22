import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;

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

class PlaceOrder extends MarketEvent {
  PlaceOrder({
    required this.symbol,
    required this.side,
    required this.quantity,
  });
  final String symbol;
  final String side;
  final int quantity;
}

class LoadPortfolio extends MarketEvent {}

class LoadOrders extends MarketEvent {}

enum MarketStatus { loading, ready, error }

class MarketState {
  MarketState({
    required this.status,
    required this.activeMarket,
    required this.instruments,
    required this.snapshots,
    required this.watchlist,
    required this.portfolioPositions,
    required this.portfolioBalance,
    required this.orders,
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
    required this.portfolioPositions,
    required this.portfolioBalance,
    required this.orders,
    required this.indices,
    required this.tradableInstruments,
    this.errorMessage,
  });

  final MarketStatus status;
  final MarketRegime activeMarket;
  final List<Instrument> instruments;
  final Map<String, MarketSnapshot> snapshots; // symbol → snapshot
  final Set<String> watchlist; // symbol set
  final Map<String, PortfolioPosition> portfolioPositions; // symbol → position
  final double portfolioBalance;
  final List<Order> orders; // order history, newest first
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
      portfolioPositions: const <String, PortfolioPosition>{},
      portfolioBalance: 0.0,
      orders: const [],
    );
  }

  MarketState copyWith({
    MarketStatus? status,
    MarketRegime? activeMarket,
    List<Instrument>? instruments,
    Map<String, MarketSnapshot>? snapshots,
    Set<String>? watchlist,
    Map<String, PortfolioPosition>? portfolioPositions,
    double? portfolioBalance,
    List<Order>? orders,
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
      portfolioPositions: portfolioPositions ?? this.portfolioPositions,
      portfolioBalance: portfolioBalance ?? this.portfolioBalance,
      orders: orders ?? this.orders,
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
  MarketBloc({ApiMarketService? marketService, required this.firebaseUid})
    : _marketService = marketService ?? ApiMarketService() {
    _init();
  }

  final String firebaseUid;

  final ApiMarketService _marketService;
  final _stateController = StreamController<MarketState>.broadcast();
  final _eventController = StreamController<MarketEvent>();

  MarketState _state = MarketState.initial();
  StreamSubscription<PriceTick>? _tickSubscription;
  Timer? _emitTimer;
  Map<String, MarketSnapshot>? _pendingUpdates;

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
    _emitTimer?.cancel();
    _tickSubscription?.cancel();
    _marketService.dispose();
    _stateController.close();
    _eventController.close();
  }

  Future<void> _handleEvent(MarketEvent event) async {
    if (event is LoadInstruments) {
      await _handleLoadInstruments();
    } else if (event is SwitchMarket) {
      await _handleSwitchMarket(event.market);
    } else if (event is UpdatePrices) {
      await _handleUpdatePrices();
    } else if (event is AddToWatchlist) {
      await _persistWatchlistAdd(event.symbol);
    } else if (event is RemoveFromWatchlist) {
      await _persistWatchlistRemove(event.symbol);
    } else if (event is RefreshMarketData) {
      await _handleRefreshMarketData();
    } else if (event is LoadPortfolio) {
      await _handleLoadPortfolio();
    } else if (event is LoadOrders) {
      await _handleLoadOrders();
    } else if (event is PlaceOrder) {
      await _handlePlaceOrder(event);
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

      // 4. Load initial portfolio + orders + watchlist
      add(LoadPortfolio());
      add(LoadOrders());
      _loadWatchlist();
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

      _pendingUpdates ??= Map<String, MarketSnapshot>.from(_state.snapshots);
      final old = _pendingUpdates![tick.symbol];

      if (old != null) {
        _pendingUpdates![tick.symbol] = old.copyWithPrice(
          price: tick.price,
          high: tick.price > old.high ? tick.price : old.high,
          low: tick.price < old.low ? tick.price : old.low,
          volume: tick.volume,
          timestamp: tick.timestamp,
        );

        if (_emitTimer == null || !_emitTimer!.isActive) {
          _emitTimer = Timer(const Duration(milliseconds: 1000), () {
            if (_pendingUpdates != null) {
              _emit(_state.copyWith(snapshots: _pendingUpdates));
              _pendingUpdates = null;
            }
          });
        }
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

  Future<void> _loadWatchlist() async {
    try {
      final symbols = await _marketService.getWatchlist(firebaseUid);
      _emit(_state.copyWith(watchlist: symbols));
    } catch (e) {
      debugPrint('Failed to load watchlist: $e');
    }
  }

  Future<void> _persistWatchlistAdd(String symbol) async {
    final newWatchlist = Set<String>.from(_state.watchlist)..add(symbol);
    _emit(_state.copyWith(watchlist: newWatchlist));
    await _marketService.watchlistAdd(firebaseUid, symbol);
  }

  Future<void> _persistWatchlistRemove(String symbol) async {
    final newWatchlist = Set<String>.from(_state.watchlist)..remove(symbol);
    _emit(_state.copyWith(watchlist: newWatchlist));
    await _marketService.watchlistRemove(firebaseUid, symbol);
  }

  Future<void> _handleRefreshMarketData() async {
    await _handleLoadInstruments();
  }

  Future<void> _handleLoadPortfolio() async {
    try {
      // NOTE: Using demo Firebase UID as specified in ADR until real Firebase Auth is wired in Flutter
      final data = await _marketService.getPortfolioPositions(firebaseUid);

      final positionsList = data['positions'] as List<dynamic>;
      final Map<String, PortfolioPosition> positionsMap = {};
      for (final p in positionsList) {
        final pos = PortfolioPosition.fromJson(p as Map<String, dynamic>);
        positionsMap[pos.symbol] = pos;
      }

      _emit(
        _state.copyWith(
          portfolioBalance: (data['balance'] as num).toDouble(),
          portfolioPositions: positionsMap,
        ),
      );
    } catch (e) {
      debugPrint('Failed to load portfolio: $e');
    }
  }

  Future<void> _handlePlaceOrder(PlaceOrder event) async {
    try {
      // NOTE: Using demo Firebase UID
      final result = await _marketService.placeOrder(
        firebaseUid: firebaseUid,
        symbol: event.symbol,
        side: event.side,
        quantity: event.quantity,
      );

      if (result['status'] == 'success') {
        // Refresh portfolio AND orders to reflect the executed trade
        add(LoadPortfolio());
        add(LoadOrders());
      }
    } catch (e) {
      _emit(_state.copyWith(errorMessage: 'Order Failed: $e'));
    }
  }

  void _emit(MarketState newState) {
    if (!_stateController.isClosed) {
      _state = newState;
      _stateController.add(_state);
    }
  }

  Future<void> _handleLoadOrders() async {
    try {
      final rawList = await _marketService.getOrders(firebaseUid);
      final orders = rawList
          .map((o) => Order.fromJson(o as Map<String, dynamic>))
          .toList();
      _emit(_state.copyWith(orders: orders));
    } catch (e) {
      debugPrint('Failed to load orders: $e');
    }
  }
}
