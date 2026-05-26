import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meetpoint/main.dart';

void main() {
  testWidgets('app renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MeetPointApp());

    expect(find.text('MeetPoint'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('initial participant count is at least two', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MeetPointApp());

    expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
    expect(find.text('Add participant'), findsOneWidget);
  });

  testWidgets('add participant button adds an input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MeetPointApp());

    final initialInputCount = find.byType(TextFormField).evaluate().length;

    await tester.tap(find.text('Add participant'));
    await tester.pump();

    expect(
      find.byType(TextFormField),
      findsNWidgets(initialInputCount + 1),
    );
  });
}
