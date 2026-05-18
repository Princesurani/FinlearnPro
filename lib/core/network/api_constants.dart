
class ApiConstants {
  static String get baseUrl {
    return 'http://${_getHost()}:8000/api/v1';
  }

  static String _getHost() {
    // Using Mac's local IP so physical devices can reach the backend
    return '192.168.1.4';
  }
}
