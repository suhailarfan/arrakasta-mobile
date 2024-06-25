class ApiEndPoints {
  static const String baseUrl = 'http://203.175.11.204/api/v1/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'register';
  final String loginEmail = 'login';
}