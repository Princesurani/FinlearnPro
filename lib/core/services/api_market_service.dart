import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../domain/instrument.dart';
import '../domain/market_data.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

String _getHost() {
  if (kIsWeb) return '127.0.0.1';
  // 10.0.2.2 is the localhost alias for Android Emulator
  if (Platform.isAndroid) return '10.0.2.2';
  
  // 127.0.0.1 works for iOS Simulator and desktop
  return '127.0.0.1';
}

class ApiMarketService {
  ApiMarketService({String? baseUrl, String? wsUrl, String? baseApiUrl})
    : baseUrl = baseUrl ?? 'http://${_getHost()}:8000/api/v1/market',
      baseApiUrl = baseApiUrl ?? 'http://${_getHost()}:8000/api/v1',
      wsUrl = wsUrl ?? 'ws://${_getHost()}:8000/ws/market/stream';

  final String baseUrl;
  final String baseApiUrl;
  final String wsUrl;
  final http.Client _client = http.Client();

  WebSocketChannel? _channel;
  StreamController<PriceTick>? _tickController;
  int _retryAttempt = 0;
  bool _isDisposed = false;

  Future<List<Instrument>> getInstruments() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/instruments'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Instrument.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load instruments');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<MarketSnapshot> getQuote(String symbol) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/quote/$symbol'));
      if (response.statusCode == 200) {
        return MarketSnapshot.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load quote for $symbol');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<MarketSnapshot>> getQuotes(List<String> symbols) async {
    try {
      final query = symbols.join(",");
      final uri = Uri.parse(
        '$baseUrl/quotes',
      ).replace(queryParameters: {'symbols': query});
      final response = await _client.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => MarketSnapshot.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load bulk quotes');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Candle>> getHistory(String symbol, Timeframe timeframe) async {
    try {
      // Send timeframe label, although Python enum uses standard strings (1m, 1h, 1D). Dart enum label happens to match if we use Timeframe.label.
      final response = await _client.get(
        Uri.parse('$baseUrl/history/$symbol?timeframe=${timeframe.label}'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Candle.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load history for $symbol');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  void _connectWebSocket() {
    if (_isDisposed) return;
    
    try {
      _channel?.sink.close();
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _channel!.stream.listen(
        (event) {
          _retryAttempt = 0; // Reset on successful connection/message
          try {
            final Map<String, dynamic> data = jsonDecode(event);
            if (data.containsKey('type') && data['type'] == 'system') return;
            if (data.containsKey('headline')) return;
            final tick = PriceTick.fromJson(data);
            if (_tickController != null && !_tickController!.isClosed) {
              _tickController!.add(tick);
            }
          } catch (_) {}
        },
        onDone: () => _scheduleReconnect(),
        onError: (error) => _scheduleReconnect(),
      );
    } catch (e) {
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (_isDisposed) return;
    // Exponential backoff: 1s, 2s, 4s, 8s, up to max 30s
    final delay = math.min(30, math.pow(2, _retryAttempt)).toInt();
    _retryAttempt++;
    Future.delayed(Duration(seconds: delay), () {
      _connectWebSocket();
    });
  }

  Stream<PriceTick> streamTicks() {
    _tickController ??= StreamController<PriceTick>.broadcast(
      onListen: () {
        _retryAttempt = 0;
        _connectWebSocket();
      },
      onCancel: () {
        // Optional: close websocket when no listeners
      }
    );
    return _tickController!.stream;
  }

  // NEW: Orders and Portfolio API

  Future<Map<String, dynamic>> placeOrder({
    required String firebaseUid,
    required String symbol,
    required String side,
    required int quantity,
    required String market,
    String type = 'market',
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseApiUrl/orders/place'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firebase_uid': firebaseUid,
          'symbol': symbol,
          'side': side,
          'quantity': quantity,
          'market': market,
          'order_type': type,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to place order: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error during order placement: $e');
    }
  }

  Future<Map<String, dynamic>> getPortfolioPositions(String firebaseUid) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseApiUrl/portfolio/positions/$firebaseUid'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load portfolio for $firebaseUid');
      }
    } catch (e) {
      throw Exception('Network error loading portfolio: $e');
    }
  }

  Future<Map<String, dynamic>> getPortfolioReview(String firebaseUid) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseApiUrl/portfolio/review/$firebaseUid'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get portfolio review: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error getting portfolio review: $e');
    }
  }

  Future<List<dynamic>> getOrders(String firebaseUid) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseApiUrl/portfolio/orders/$firebaseUid'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to load orders for $firebaseUid');
      }
    } catch (e) {
      throw Exception('Network error loading orders: $e');
    }
  }

  Future<Set<String>> getWatchlist(String firebaseUid) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseApiUrl/portfolio/watchlist/$firebaseUid'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return Set<String>.from(data['symbols'] as List);
      }
    } catch (_) {}
    return {};
  }

  Future<void> watchlistAdd(String firebaseUid, String symbol) async {
    try {
      await _client.post(
        Uri.parse('$baseApiUrl/portfolio/watchlist/$firebaseUid/$symbol'),
      );
    } catch (_) {}
  }

  Future<void> watchlistRemove(String firebaseUid, String symbol) async {
    try {
      await _client.delete(
        Uri.parse('$baseApiUrl/portfolio/watchlist/$firebaseUid/$symbol'),
      );
    } catch (_) {}
  }

  void dispose() {
    _isDisposed = true;
    _channel?.sink.close();
    _channel = null;
    _tickController?.close();
    _tickController = null;
    _client.close();
  }
}
