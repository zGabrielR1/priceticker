import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  String? _token;
  void Function()? onSessionChanged;
  int _sessionVersion = 0;
  int get sessionVersion => _sessionVersion;
  Future<void> _tokenWrites = Future.value();

  static const _tokenKey = 'auth_token';

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_tokenKey);
    if (_token != saved) {
      _token = saved;
      _sessionVersion++;
      onSessionChanged?.call();
    }
  }

  Future<void> setToken(String? token) {
    if (_token != token) {
      _token = token;
      _sessionVersion++;
      onSessionChanged?.call();
    }
    // Persist transitions in order so an earlier logout cannot erase a later login.
    final write = _tokenWrites.then((_) async {
      final prefs = await SharedPreferences.getInstance();
      if (token == null) {
        await prefs.remove(_tokenKey);
      } else {
        await prefs.setString(_tokenKey, token);
      }
    });
    _tokenWrites = write.catchError((Object _) {});
    return write;
  }

  void close() => _client.close();

  String? get token => _token;
  bool get isAuthenticated => _token != null;

  Map<String, String> _headers({bool json = true}) {
    final h = <String, String>{'Accept': 'application/json'};
    if (json) h['Content-Type'] = 'application/json';
    if (_token != null) h['Authorization'] = 'Bearer $_token';
    return h;
  }

  Uri _uri(String path, [Map<String, dynamic>? query]) {
    final base = AppConfig.baseUrl.endsWith('/')
        ? AppConfig.baseUrl.substring(0, AppConfig.baseUrl.length - 1)
        : AppConfig.baseUrl;
    return Uri.parse('$base$path')
        .replace(queryParameters: query?.map((k, v) => MapEntry(k, '$v')));
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final session = _sessionVersion;
    final res = await _client
        .get(_uri(path, query), headers: _headers(json: false))
        .timeout(const Duration(seconds: 30));
    return _decode(res, session);
  }

  Future<Map<String, dynamic>> post(String path, {Object? body}) async {
    final session = _sessionVersion;
    final res = await _client
        .post(_uri(path), headers: _headers(), body: jsonEncode(body ?? {}))
        .timeout(const Duration(seconds: 30));
    return _decode(res, session);
  }

  Future<Map<String, dynamic>> put(String path, {Object? body}) async {
    final session = _sessionVersion;
    final res = await _client
        .put(_uri(path), headers: _headers(), body: jsonEncode(body ?? {}))
        .timeout(const Duration(seconds: 30));
    return _decode(res, session);
  }

  Future<void> delete(String path) async {
    final session = _sessionVersion;
    final res = await _client
        .delete(_uri(path), headers: _headers(json: false))
        .timeout(const Duration(seconds: 30));
    await _decode(res, session);
  }

  Future<Map<String, dynamic>> _decode(http.Response res, int session) async {
    if (session != _sessionVersion) throw const SessionChangedException();
    if (res.statusCode == 401) {
      await setToken(null);
    }
    if (res.statusCode >= 400) {
      throw ApiException(res.statusCode, res.body);
    }
    if (res.body.isEmpty) return {};
    final decoded = jsonDecode(res.body);
    if (decoded is Map<String, dynamic>) return decoded;
    return {'data': decoded};
  }
}

class ApiException implements Exception {
  ApiException(this.statusCode, this.body);
  final int statusCode;
  final String body;
  @override
  String toString() => 'ApiException($statusCode): $body';
}

class SessionChangedException implements Exception {
  const SessionChangedException();
}
