import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mobile/core/api_client.dart';
import 'package:mobile/data/models/watch.dart';
import 'package:mobile/data/repositories/watch_repository.dart';
import 'package:mobile/data/repositories/alert_repository.dart';
import 'package:mobile/presentation/providers/watch_provider.dart';
import 'package:mobile/presentation/providers/alert_provider.dart';

void main() {
  test(
    'failed watch refresh clears old data and exposes a recoverable error',
    () async {
      var failing = false;
      final api = ApiClient(
        client: MockClient(
          (_) async => failing
              ? http.Response('{}', 503)
              : http.Response(
                  jsonEncode({
                    'data': [
                      {'id': 1, 'name': 'GPU', 'type': 'product'},
                    ],
                  }),
                  200,
                ),
        ),
      );
      final provider = WatchProvider(WatchRepository(api));
      await provider.load();
      expect(provider.watches, hasLength(1));
      failing = true;
      await provider.load();
      expect(provider.watches, isEmpty);
      expect(provider.error, isNotNull);
      expect(provider.loading, isFalse);
      failing = false;
      await provider.load();
      expect(provider.error, isNull);
      expect(provider.watches, hasLength(1));
    },
  );

  test(
    'failed pause and delete preserve the watch and release busy state',
    () async {
      final api = ApiClient(
        client: MockClient((_) async => http.Response('{}', 503)),
      );
      final provider = WatchProvider(WatchRepository(api));
      final watch = Watch(id: 1, type: 'product', name: 'GPU');
      provider.watches = [watch];
      await provider.setActive(watch, false);
      expect(provider.watches.single.isActive, isTrue);
      expect(provider.busy, isEmpty);
      expect(provider.error, isNotNull);
      await provider.remove(1);
      expect(provider.watches, hasLength(1));
      expect(provider.busy, isEmpty);
    },
  );

  test(
    'alert refresh failure is handled without an uncaught exception',
    () async {
      final api = ApiClient(
        client: MockClient((_) async => http.Response('{}', 503)),
      );
      final provider = AlertProvider(AlertRepository(api));
      await provider.load();
      expect(provider.error, isNotNull);
      expect(provider.loading, isFalse);
      await provider.markRead('unavailable-alert');
      expect(provider.error, isNotNull);
      expect(provider.busy, isEmpty);
    },
  );
}
