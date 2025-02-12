import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:demo/models/post.dart';
import 'package:demo/pages/home.dart';
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

  testWidgets('Home page should have AppBar with X logo and profile picture',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Home(),
    ));

    // Verify AppBar exists
    expect(
      find.byType(AppBar),
      findsOneWidget,
      reason: 'There should be an AppBar in the Home page',
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
      reason: 'The X logo should be using the correct asset',
    );

    // Verify image width is set to 30
    expect(image.width, 30, reason: 'The X logo should be 30px wide');

    // Verify CircleAvatar exists in AppBar
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(CircleAvatar),
      ),
      findsOneWidget,
      reason: 'There should be a CircleAvatar in the AppBar',
    );

    // Verify CircleAvatar properties
    final CircleAvatar avatar = tester.widget<CircleAvatar>(
      find.byType(CircleAvatar),
    );
    expect(avatar.radius, 15, reason: 'The avatar radius should be 15');

    // Verify CircleAvatar is wrapped in Center widget
    expect(
      find.ancestor(
        of: find.byType(CircleAvatar),
        matching: find.byType(Center),
      ),
      findsOneWidget,
      reason: 'The CircleAvatar should be centered',
    );
  });

  testWidgets('TabBar should have correct properties and tabs',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Home(),
    ));

    // Verify TabBar exists
    expect(
      find.byType(TabBar),
      findsOneWidget,
      reason: 'There should be a TabBar in the AppBar',
    );

    // Verify all three tabs exist with correct text
    expect(find.text('For you'), findsOneWidget,
        reason: 'Should have "For you" tab');
    expect(find.text('Following'), findsOneWidget,
        reason: 'Should have "Following" tab');
    expect(find.text('Subscribed'), findsOneWidget,
        reason: 'Should have "Subscribed" tab');

    // Get TabBar widget to verify its properties
    final TabBar tabBar = tester.widget<TabBar>(find.byType(TabBar));

    // Verify TabBar properties
    expect(tabBar.unselectedLabelColor, Colors.grey,
        reason: 'Unselected tabs should be grey');
    expect(tabBar.indicatorColor, Colors.blue,
        reason: 'Tab indicator should be blue');
    expect(tabBar.dividerHeight, 0.5, reason: 'Divider height should be 0.5');
    expect(tabBar.dividerColor, Colors.grey, reason: 'Divider should be grey');

    // Verify tab label style
    expect(tabBar.labelStyle?.fontWeight, FontWeight.bold,
        reason: 'Tab labels should be bold');

    // Test tab switching
    await tester.tap(find.text('Following'));
    await tester.pumpAndSettle();

    // Verify DefaultTabController index updated
    expect(
      DefaultTabController.of(tester.element(find.byType(TabBar))).index,
      1,
      reason: 'TabController should be on index 1 after tapping "Following"',
    );
  });

  testWidgets('TabBarView should display correct content for each tab',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Home(),
    ));

    expect(find.text('Following Tab'), findsNothing,
        reason: 'Should not show "Following" content initially');
    expect(find.text('Subscribed Tab'), findsNothing,
        reason: 'Should not show "Subscribed" content initially');

    // Switch to "Following" tab and verify content
    await tester.tap(find.text('Following'));
    await tester.pumpAndSettle();

    expect(find.text('Following Tab'), findsOneWidget,
        reason: 'Should show "Following" content after switching');
    expect(find.text('Subscribed Tab'), findsNothing,
        reason: 'Should not show "Subscribed" content');

    // Switch to "Subscribed" tab and verify content
    await tester.tap(find.text('Subscribed'));
    await tester.pumpAndSettle();

    expect(find.text('Following Tab'), findsNothing,
        reason: 'Should not show "Following" content');
    expect(find.text('Subscribed Tab'), findsOneWidget,
        reason: 'Should show "Subscribed" content after switching');
  });

  // testWidgets('ListView.builder should display posts correctly',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //     home: Home(),
  //   ));

  //   // Verify ListView.builder exists in the first tab
  //   expect(
  //     find.byType(ListView),
  //     findsOneWidget,
  //     reason: 'Should have a ListView in the "For you" tab',
  //   );

  //   // Verify all sample posts are displayed
  //   for (final post in Post.samplePosts) {
  //     expect(
  //       find.text(post.content),
  //       findsOneWidget,
  //       reason: 'Should display post content: ${post.content}',
  //     );
  //   }

  //   // Verify PostEntry widgets are created for each post
  //   expect(
  //     find.byType(PostEntry),
  //     findsNWidgets(Post.samplePosts.length),
  //     reason: 'Should have a PostEntry widget for each sample post',
  //   );

  //   // Test scrolling if there are multiple posts
  //   if (Post.samplePosts.length > 1) {
  //     final firstPostContent = Post.samplePosts.first.content;
  //     final lastPostContent = Post.samplePosts.last.content;

  //     // Verify first post is visible initially
  //     expect(find.text(firstPostContent), findsOneWidget);

  //     // Scroll to the bottom
  //     await tester.dragFrom(
  //       tester.getCenter(find.byType(ListView)),
  //       const Offset(0, -100),
  //     );
  //     await tester.pumpAndSettle();

  //     // Verify last post is now visible
  //     expect(find.text(lastPostContent), findsOneWidget);
  //   }
  // });
}
