import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mobile/core/api_client.dart';
import 'package:mobile/data/repositories/watch_repository.dart';
import 'package:mobile/data/repositories/auth_repository.dart';
import 'package:mobile/presentation/providers/watch_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final status in [200, 401]) {
    test('old session response ($status) cannot affect a new login', () async {
      SharedPreferences.setMockInitialValues({});
      final response = Completer<http.Response>();
      final started = Completer<void>();
      final api = ApiClient(
        client: MockClient((_) {
          started.complete();
          return response.future;
        }),
      );
      await api.setToken('old');
      final pending = api.get('/private');
      final assertion = expectLater(
        pending,
        throwsA(isA<SessionChangedException>()),
      );
      await started.future;
      await api.setToken('new');
      response.complete(http.Response('{}', status));
      await assertion;
      expect(api.token, 'new');
      expect(
        (await SharedPreferences.getInstance()).getString('auth_token'),
        'new',
      );
    });
  }

  test(
    'DELETE 401 clears the current token and notifies the session owner',
    () async {
      SharedPreferences.setMockInitialValues({});
      final api = ApiClient(
        client: MockClient((_) async => http.Response('{}', 401)),
      );
      await api.setToken('expired');
      var changed = 0;
      api.onSessionChanged = () {
        changed++;
      };
      await expectLater(api.delete('/watch/1'), throwsA(isA<ApiException>()));
      expect(api.token, isNull);
      expect(changed, 1);
      expect(
        (await SharedPreferences.getInstance()).getString('auth_token'),
        isNull,
      );
    },
  );

  test('reset discards an already running private list load', () async {
    final response = Completer<http.Response>();
    final api = ApiClient(client: MockClient((_) => response.future));
    final provider = WatchProvider(WatchRepository(api));
    final pending = provider.load();
    provider.reset();
    response.complete(
      http.Response(
        jsonEncode({
          'data': [
            {'id': 1, 'type': 'product', 'name': 'Private watch'},
          ],
        }),
        200,
      ),
    );
    await pending;
    expect(provider.watches, isEmpty);
    expect(provider.error, isNull);
    expect(provider.loading, isFalse);
    provider.dispose();
  });

  test('an old logout cannot clear a newer login', () async {
    SharedPreferences.setMockInitialValues({});
    final response = Completer<http.Response>();
    final started = Completer<void>();
    final api = ApiClient(
      client: MockClient((_) {
        started.complete();
        return response.future;
      }),
    );
    await api.setToken('old');
    final pending = AuthRepository(api).logout();
    final assertion = expectLater(
      pending,
      throwsA(isA<SessionChangedException>()),
    );
    await started.future;
    await api.setToken('new');
    response.complete(http.Response('{}', 200));
    await assertion;
    expect(api.token, 'new');
  });
}
