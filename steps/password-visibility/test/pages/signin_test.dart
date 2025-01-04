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

  testWidgets('SignIn page should have username and password fields',
      (WidgetTester tester) async {
    // Build the SignIn widget
    await tester.pumpWidget(const MaterialApp(
      home: SignIn(),
    ));

    // Verify title text exists and has correct style
    final titleFinder = find.text('Enter your password');
    expect(titleFinder, findsOneWidget);

    final Text titleWidget = tester.widget<Text>(titleFinder);
    expect(titleWidget.style?.fontSize, 28);
    expect(titleWidget.style?.fontWeight, FontWeight.bold);

    // Verify Form exists
    expect(find.byType(Form), findsOneWidget);

    // Verify TextFormFields exist with correct hints
    final usernameFinder = find.widgetWithText(TextFormField, 'Username');
    final passwordFinder = find.widgetWithText(TextFormField, 'Password');

    expect(usernameFinder, findsOneWidget);
    expect(passwordFinder, findsOneWidget);

    // Get the TextFields (not TextFormFields)
    final List<TextField> textFields =
        tester.widgetList<TextField>(find.byType(TextField)).toList();

    final usernameTextField = textFields.first;
    final passwordTextField = textFields.last;

    // Check username field decoration properties individually
    expect(usernameTextField.decoration?.hintText, 'Username');
    expect(
      usernameTextField.decoration?.enabledBorder,
      const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
    expect(
      usernameTextField.decoration?.focusedBorder,
      const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    );

    // Check password field decoration properties individually
    expect(passwordTextField.decoration?.hintText, 'Password');
    expect(
      passwordTextField.decoration?.enabledBorder,
      const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
    expect(
      passwordTextField.decoration?.focusedBorder,
      const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    );

    // Verify password field is obscured
    expect(passwordTextField.obscureText, true);

    // Verify SizedBox spacings
    final titleToUsername = find.descendant(
      of: find.byType(Column),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == 20,
      ),
    );

    final usernameToPassword = find.descendant(
      of: find.byType(Column),
      matching: find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == 10,
      ),
    );

    expect(
      titleToUsername,
      findsOneWidget,
      reason: 'SizedBox between title and username should be 20',
    );

    expect(
      usernameToPassword,
      findsOneWidget,
      reason: 'SizedBox between username and password should be 10',
    );
  });
  testWidgets('Password visibility can be toggled',
      (WidgetTester tester) async {
    // Build the SignIn widget
    await tester.pumpWidget(const MaterialApp(
      home: SignIn(),
    ));

    final visibilityToggle = find.byIcon(Icons.visibility_off);

    // Initially password should be obscured
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      true,
    );
    expect(visibilityToggle, findsOneWidget);

    // Tap the visibility toggle
    await tester.tap(visibilityToggle);
    await tester.pumpAndSettle();

    // Password should now be visible
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      false,
    );
    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsNothing);

    // Tap again to hide password
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pumpAndSettle();

    // Password should be obscured again
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      true,
    );
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);
  });
}
