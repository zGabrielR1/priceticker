import 'package:flutter/foundation.dart';
import '../../core/api_client.dart';
import '../../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._repo, this._api);
  final AuthRepository _repo;
  final ApiClient _api;

  bool _loading = false;
  bool get loading => _loading;
  bool get isAuthenticated => _api.isAuthenticated;

  Future<void> init() async => _api.loadToken();

  Future<void> login(String email, String password) async {
    _loading = true;
    notifyListeners();
    try {
      await _repo.login(email, password);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    notifyListeners();
  }
}
