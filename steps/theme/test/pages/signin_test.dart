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
    expect(find.byType(AppBar), findsOneWidget);

    // Verify Image widget exists in AppBar
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(Image),
      ),
      findsOneWidget,
    );

    // Verify the correct image asset is used
    final Image image = tester.widget<Image>(find.byType(Image));
    expect(
      (image.image as AssetImage).assetName,
      'assets/x-logo.png',
    );

    // Verify image width is set to 30
    expect(image.width, 30);
  });
}
