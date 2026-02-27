import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frisidea_flutter_test/main.dart';

void main() {
  testWidgets('Financial tracking app loads correctly', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the app title is correct.
    expect(find.text('Pencatatan Keuangan'), findsOneWidget);

    // Verify that balance card elements are present.
    expect(find.text('Total Balance'), findsOneWidget);
    expect(find.text('Income'), findsOneWidget);
    expect(find.text('Expense'), findsOneWidget);

    // Verify that the FAB is present for adding transactions.
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Verify empty state message when no transactions exist.
    expect(find.text('No transactions yet'), findsOneWidget);
  });
}
