// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should have correct theme settings',
      (WidgetTester tester) async {
    // Build the MyApp widget
    await tester.pumpWidget(const MyApp());

    // Get the MaterialApp widget
    final MaterialApp materialApp =
        tester.widget<MaterialApp>(find.byType(MaterialApp));
    final ThemeData theme = materialApp.theme!;

    // Test AppBar theme
    expect(
      theme.appBarTheme.backgroundColor,
      Colors.black,
      reason: 'AppBar should have a black background color',
    );

    // Test BottomNavigationBar theme
    expect(
      theme.bottomNavigationBarTheme.backgroundColor,
      Colors.black,
      reason: 'BottomNavigationBar should have a black background color',
    );

    // Test ColorScheme
    expect(
      theme.colorScheme.primary,
      Colors.white,
      reason: 'Primary color should be white',
    );
    expect(
      theme.colorScheme.secondary,
      Colors.grey,
      reason: 'Secondary color should be grey',
    );
    expect(
      theme.colorScheme.brightness,
      Brightness.dark,
      reason: 'ColorScheme should use dark brightness',
    );

    // Test Scaffold background color
    expect(
      theme.scaffoldBackgroundColor,
      Colors.black,
      reason: 'Scaffold background should be black',
    );

    // Test Text theme
    expect(
      theme.textTheme.bodyMedium?.fontSize,
      16,
      reason: 'Default body text size should be 16',
    );
  });

  testWidgets('Theme should be applied to widgets correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find Scaffold and verify background color
    final Material scaffold = tester.widget<Material>(
      find
          .descendant(
            of: find.byType(Scaffold),
            matching: find.byType(Material),
          )
          .first,
    );
    expect(
      scaffold.color,
      Colors.black,
      reason: 'Scaffold should render with black background color',
    );
    // Removed because this is not even a real lesson, it's just starting point with Home as the default
    // Find AppBar and verify background color
    // final Material appBar = tester.widget<Material>(
    //   find
    //       .descendant(
    //         of: find.byType(AppBar),
    //         matching: find.byType(Material),
    //       )
    //       .first,
    // );
    // expect(
    //   appBar.color,
    //   Colors.black,
    //   reason: 'AppBar should render with black background color',
    // );
  });
}
