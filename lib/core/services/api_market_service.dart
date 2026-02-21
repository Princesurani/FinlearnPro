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
  ApiMarketService({String? baseUrl, String? wsUrl})
    : baseUrl = baseUrl ?? 'http://${_getHost()}:8000/api/v1/market',
      wsUrl = wsUrl ?? 'ws://${_getHost()}:8000/ws/market/stream';

  final String baseUrl;
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
              if (data.containsKey('type') && data['type'] == 'system')
                return null;
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

  void dispose() {
    _channel?.sink.close();
    _channel = null;
    _tickStream = null;
  }
}
