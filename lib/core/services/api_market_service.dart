import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../domain/instrument.dart';
import '../domain/market_data.dart';

String _getHost() {
  try {
    if (!kIsWeb && Platform.isAndroid) {
      return '10.0.2.2';
    }
  } catch (_) {}
  return 'localhost';
}

class ApiMarketService {
  ApiMarketService({String? baseUrl, String? wsUrl, String? baseApiUrl})
    : baseUrl = baseUrl ?? 'http://${_getHost()}:8000/api/v1/market',
      baseApiUrl = baseApiUrl ?? 'http://${_getHost()}:8000/api/v1',
      wsUrl = wsUrl ?? 'ws://${_getHost()}:8000/ws/market/stream';

  final String baseUrl;
  final String baseApiUrl;
  final String wsUrl;

  WebSocketChannel? _channel;
  Stream<PriceTick>? _tickStream;

  Future<List<Instrument>> getInstruments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/instruments'));
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
      final response = await http.get(Uri.parse('$baseUrl/quote/$symbol'));
      if (response.statusCode == 200) {
        return MarketSnapshot.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load quote for $symbol');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Candle>> getHistory(String symbol, Timeframe timeframe) async {
    try {
      // Send timeframe label, although Python enum uses standard strings (1m, 1h, 1D). Dart enum label happens to match if we use Timeframe.label.
      final response = await http.get(
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

  Stream<PriceTick> streamTicks() {
    if (_channel == null || _tickStream == null) {
      _channel ??= WebSocketChannel.connect(Uri.parse(wsUrl));

      _tickStream = _channel!.stream
          .map((event) {
            try {
              final Map<String, dynamic> data = jsonDecode(event);
              if (data.containsKey('type') && data['type'] == 'system') {
                return null;
              }
              if (data.containsKey('headline')) return null;
              return PriceTick.fromJson(data);
            } catch (e) {
              return null;
            }
          })
          .where((tick) => tick != null)
          .cast<PriceTick>()
          .asBroadcastStream();
    }

    return _tickStream!;
  }

  // NEW: Orders and Portfolio API

  Future<Map<String, dynamic>> placeOrder({
    required String firebaseUid,
    required String symbol,
    required String side,
    required int quantity,
    String type = 'market',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseApiUrl/orders/place'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firebase_uid': firebaseUid,
          'symbol': symbol,
          'side': side,
          'quantity': quantity,
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
      final response = await http.get(
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

  Future<List<dynamic>> getOrders(String firebaseUid) async {
    try {
      final response = await http.get(
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
      final response = await http.get(
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
      await http.post(
        Uri.parse('$baseApiUrl/portfolio/watchlist/$firebaseUid/$symbol'),
      );
    } catch (_) {}
  }

  Future<void> watchlistRemove(String firebaseUid, String symbol) async {
    try {
      await http.delete(
        Uri.parse('$baseApiUrl/portfolio/watchlist/$firebaseUid/$symbol'),
      );
    } catch (_) {}
  }

  void dispose() {
    _channel?.sink.close();
    _channel = null;
    _tickStream = null;
  }
}
