import 'package:flutter/foundation.dart';

import '../../core/api_client.dart';
import '../../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._repo, this._api, {void Function()? onSessionChanged}) {
    _api.onSessionChanged = () {
      onSessionChanged?.call();
      _notify();
    };
  }
  final AuthRepository _repo;
  final ApiClient _api;

  bool _disposed = false;
  bool _loading = false;

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  bool get loading => _loading;
  bool get isAuthenticated => _api.isAuthenticated;

  Future<void> init() async => _api.loadToken();

  Future<void> login(String email, String password) async {
    _loading = true;
    _notify();
    try {
      await _repo.login(email, password);
    } finally {
      _loading = false;
      _notify();
    }
  }

  Future<void> logout() async {
    try {
      await _repo.logout();
    } finally {
      _notify();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _api.onSessionChanged = null;
    super.dispose();
  }
}
