// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  testWidgets('Portfolio app renders main navigation content', (
    WidgetTester tester,
  ) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Abdallah Gaber'), findsWidgets);
    expect(find.text('Projects'), findsWidgets);
  });

  testWidgets('Theme toggle switches icon state', (WidgetTester tester) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byTooltip('Switch to light mode'), findsOneWidget);

    await tester.tap(find.byTooltip('Switch to light mode'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byTooltip('Switch to dark mode'), findsOneWidget);
  });
}
