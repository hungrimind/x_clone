import 'package:demo/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SignIn page should have AppBar with X logo',
      (WidgetTester tester) async {
    // Build the SignIn widget
    await tester.pumpWidget(const MaterialApp(
      home: SignIn(),
    ));

    // Verify AppBar exists
    expect(
      find.byType(AppBar),
      findsOneWidget,
      reason: 'There should be an AppBar in the SignIn page',
    );

    // Verify Image widget exists in AppBar
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(Image),
      ),
      findsOneWidget,
      reason: 'There should be an X logo in the AppBar',
    );

    // Verify the correct image asset is used
    final Image image = tester.widget<Image>(find.byType(Image));
    expect(
      (image.image as AssetImage).assetName,
      'assets/x-logo.png',
      reason: 'There should be an X logo in the AppBar',
    );

    // Verify image width is set to 30
    expect(image.width, 30, reason: 'The X logo should be 30px');
  });
}
