import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mobile/app.dart';
import 'package:mobile/core/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('editing preserves paused state and settings outside the form', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    Map<String, dynamic> watch = {
      'id': 7,
      'type': 'product',
      'name': 'My GPU',
      'is_active': false,
      'config': {
        'keywords': ['RTX'],
        'urls': ['https://store.example/rtx/p'],
        'custom': 'keep',
      },
      'rules': {
        'max_price': 90,
        'min_pct_below_30d': 15,
        'cooldown_minutes': 120,
        'channels': ['app'],
      },
    };
    Map<String, dynamic>? submitted;
    final api = ApiClient(
      client: MockClient((request) async {
        if (request.method == 'PUT') {
          submitted = jsonDecode(request.body) as Map<String, dynamic>;
          watch = {...submitted!, 'id': 7};
          return http.Response(jsonEncode({'data': watch}), 200);
        }
        if (request.url.path == '/api/v1/watches/7') {
          return http.Response(jsonEncode({'data': watch}), 200);
        }
        if (request.url.path == '/api/v1/watches') {
          return http.Response(
            jsonEncode({
              'data': [watch],
            }),
            200,
          );
        }
        return http.Response(jsonEncode({'data': []}), 200);
      }),
    );
    await api.setToken('test');
    await tester.pumpWidget(PriceTickerApp(api: api));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Watches'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit watch'));
    await tester.pumpAndSettle();
    expect(find.text('Edit watch'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, 'Updated GPU');
    await tester.ensureVisible(find.text('Save changes'));
    await tester.tap(find.text('Save changes'));
    await tester.pumpAndSettle();
    expect(submitted?['name'], 'Updated GPU');
    expect(submitted?['is_active'], false);
    expect(submitted?['config']['custom'], 'keep');
    expect(submitted?['config']['urls'], ['https://store.example/rtx/p']);
    expect(submitted?['rules']['min_pct_below_30d'], 15);
    expect(submitted?['rules']['cooldown_minutes'], 120);
    expect(submitted?['rules']['channels'], ['app']);
    await tester.pumpWidget(const SizedBox());
  });
}
