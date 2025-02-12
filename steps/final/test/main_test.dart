// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:demo/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestImageProvider extends ImageProvider<Object> {
  @override
  Future<Object> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<Object>(this);
  }

  @override
  ImageStream createStream(ImageConfiguration configuration) {
    return MockImageStream();
  }
}

class MockImageStream extends ImageStream {
  @override
  void addListener(ImageStreamListener listener) {
    // Provide a 1x1 transparent image
    listener.onImage(ImageInfo(image: MockImage()), true);
  }
}

class MockImage implements ui.Image {
  @override
  int get width => 1;

  @override
  int get height => 1;

  @override
  void dispose() {}

  @override
  Future<ByteData?> toByteData({ui.ImageByteFormat? format}) async => null;

  @override
  bool get debugDisposed => false;

  @override
  ui.ColorSpace get colorSpace => ui.ColorSpace.sRGB;

  @override
  bool isCloneOf(ui.Image other) => true;

  @override
  ui.Image clone() => this;

  @override
  List<StackTrace>? debugGetOpenHandleStackTraces() => null;
}

class MockHttpClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return MockHttpClientRequest();
  }

  @override
  bool autoUncompress = true;
}

class MockHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async {
    return MockHttpClientResponse();
  }
}

class MockHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => kTransparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(void Function(List<int>)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return Stream<List<int>>.fromIterable([kTransparentImage]).listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

// 1x1 transparent pixel in PNG format
const kTransparentImage = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82
];

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return MockHttpClient();
  }
}

void setUpHttpOverrides() {
  HttpOverrides.global = MockHttpOverrides();
}

void main() {
  setUp(() {
    // Set up HTTP mocking before each test
    setUpHttpOverrides();
  });

  tearDown(() {
    // Clean up after each test
    HttpOverrides.global = null;
  });

  testWidgets('App should have correct theme settings',
      (WidgetTester tester) async {
    // Build the MyApp widget
    await tester.pumpWidget(const MyApp());
    await tester
        .pumpAndSettle(); // Wait for all animations and timers to complete

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
    await tester
        .pumpAndSettle(); // Wait for all animations and timers to complete

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

    // Find AppBar and verify background color
    final Material appBar = tester.widget<Material>(
      find
          .descendant(
            of: find.byType(AppBar),
            matching: find.byType(Material),
          )
          .first,
    );
    expect(
      appBar.color,
      Colors.black,
      reason: 'AppBar should render with black background color',
    );
  });
}
