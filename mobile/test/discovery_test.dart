import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mobile/app.dart';
import 'package:mobile/core/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('sign-in opens the deal feed on the same authenticated client', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final api = ApiClient(
      client: MockClient((request) async {
        if (request.url.path.endsWith('/auth/token')) {
          return http.Response(jsonEncode({'token': 'test-token'}), 200);
        }
        expect(request.headers['Authorization'], 'Bearer test-token');
        return http.Response(jsonEncode({'data': []}), 200);
      }),
    );
    await tester.pumpWidget(PriceTickerApp(api: api));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'me@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Your deal radar'), findsOneWidget);
    expect(
      find.text('No retailer sources are configured on this server yet.'),
      findsOneWidget,
    );
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('a restored session shows request failures with a retry', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'auth_token': 'saved-token'});
    final api = ApiClient(
      client: MockClient((request) async => http.Response('{}', 503)),
    );
    await api.loadToken();
    await tester.pumpWidget(PriceTickerApp(api: api));
    await tester.pumpAndSettle();
    expect(find.text('Your deal radar'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(
      find.text('Waiting for a price worth your attention.'),
      findsNothing,
    );
    await tester.pumpWidget(const SizedBox());
  });
}
