import 'dart:io';

class ApiConstants {
  static String get baseUrl {
    return 'http://${_getHost()}:8000/api/v1';
  }

  static String _getHost() {
    try {
      if (Platform.isAndroid) {
        return '10.0.2.2'; // Android emulator localhost
      }
    } catch (_) {}
    return 'localhost'; // iOS simulator or web
  }
}
