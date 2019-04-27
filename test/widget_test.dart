// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:taptaptap2/widget/app.dart';
import 'package:taptaptap2/widget/playground.dart';
import 'package:taptaptap2/widget/shape_widget.dart';

void main() {
  testWidgets('Has Circles', (WidgetTester tester) async {
    await tester.runAsync(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Playground), pointer: 0);
      await tester.tap(find.byType(Playground), pointer: 1);
      await tester.tap(find.byType(Playground), pointer: 2);
      await tester.pump();

      expect(find.byType(ShapeWidget), findsNWidgets(3));
    });
  });
}
