import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl {
    // If API_URL is set in .env, use it. Otherwise, default to local.
    final envUrl = dotenv.env['API_URL'];
    if (envUrl != null && envUrl.isNotEmpty) return envUrl;
    return 'http://${_getHost()}:8000/api/v1';
  }

  static String get wsUrl {
    final envWs = dotenv.env['WS_URL'];
    if (envWs != null && envWs.isNotEmpty) return envWs;
    return 'ws://${_getHost()}:8000/ws/market';
  }

  static String _getHost() {
    if (kIsWeb) return '127.0.0.1';
    if (Platform.isAndroid) return '10.0.2.2';
    return '127.0.0.1';
  }
}
