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

  testWidgets('SignIn page should have properly styled buttons at the bottom',
      (WidgetTester tester) async {
    // Build the SignIn widget
    await tester.pumpWidget(const MaterialApp(
      home: SignIn(),
    ));

    // Verify Login button exists and has correct styling
    final loginButton = find.widgetWithText(ElevatedButton, 'Log in');
    expect(loginButton, findsOneWidget);

    final ElevatedButton loginButtonWidget = tester.widget(loginButton);
    expect(
      loginButtonWidget.style?.backgroundColor?.resolve({}),
      Colors.white,
      reason: 'Login button should have white background',
    );
    expect(
      loginButtonWidget.style?.foregroundColor?.resolve({}),
      Colors.black,
      reason: 'Login button text should be black',
    );

    // Verify button shape and size
    final ButtonStyle? style = loginButtonWidget.style;
    final borderRadius = style?.shape?.resolve({}) as RoundedRectangleBorder?;
    expect(
      borderRadius?.borderRadius,
      BorderRadius.circular(30),
      reason: 'Login button should have 30px border radius',
    );
    expect(
      style?.minimumSize?.resolve({})?.width,
      double.infinity,
      reason: 'Login button should stretch full width',
    );
    expect(
      style?.minimumSize?.resolve({})?.height,
      50,
      reason: 'Login button should be 50px high',
    );

    // Verify Forgot password button exists and has correct styling
    final forgotButton = find.widgetWithText(TextButton, 'Forgot password?');
    expect(forgotButton, findsOneWidget);

    final Text forgotButtonText = tester.widget<Text>(
      find.descendant(
        of: forgotButton,
        matching: find.byType(Text),
      ),
    );

    expect(
      forgotButtonText.style?.decoration,
      TextDecoration.underline,
      reason: 'Forgot password text should be underlined',
    );
    expect(
      forgotButtonText.style?.fontWeight,
      FontWeight.bold,
      reason: 'Forgot password text should be bold',
    );

    // Verify buttons are at the bottom using Spacer
    expect(
      find.byType(Spacer),
      findsOneWidget,
      reason: 'Spacer should push buttons to bottom',
    );

    // Verify login button padding - using a more specific finder
    final loginButtonContainer = find
        .ancestor(
          of: loginButton,
          matching: find.byType(Padding),
          matchRoot: true, // Only match the immediate parent
        )
        .first;

    final paddingWidget = tester.widget<Padding>(loginButtonContainer);
    expect(
      paddingWidget.padding,
      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      reason: 'Login button should have correct padding',
    );
  });
}
