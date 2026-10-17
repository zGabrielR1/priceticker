import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app.dart';

void main() {
  testWidgets('app builds', (WidgetTester tester) async {
    await tester.pumpWidget(PriceTickerApp());
    await tester.pump();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
