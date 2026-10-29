import '../../core/api_client.dart';

class AuthRepository {
  AuthRepository(this._api);
  final ApiClient _api;

  Future<void> login(String email, String password) async {
    final res = await _api.post(
      '/api/v1/auth/token',
      body: {
        'email': email,
        'password': password,
        'device_name': 'flutter-app',
      },
    );
    await _api.setToken(res['token'] as String);
  }

  Future<void> logout() async {
    final session = _api.sessionVersion;
    try {
      await _api.post('/api/v1/auth/revoke');
    } finally {
      if (_api.sessionVersion == session) await _api.setToken(null);
    }
  }
}
