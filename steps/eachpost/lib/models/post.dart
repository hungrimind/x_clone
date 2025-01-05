class Post {
  final String name;
  final String handle;
  final bool verified;
  final String time;
  final String content;
  final String comments;
  final String reposts;
  final String likes;
  final String views;
  final String profilePictureUrl;

  Post({
    required this.name,
    required this.handle,
    required this.verified,
    required this.time,
    required this.content,
    required this.comments,
    required this.reposts,
    required this.likes,
    required this.views,
    required this.profilePictureUrl,
  });

  static List<Post> samplePosts = [
    Post(
      name: 'DogeDesigner',
      handle: 'cb_doge',
      verified: true,
      time: '1h',
      content: 'This is my first post on X Hello world.',
      comments: '9.2K',
      reposts: '10.5K',
      likes: '116K',
      views: '11M',
      profilePictureUrl:
          'https://pbs.twimg.com/profile_images/1498070100393754625/C2V-fbll_400x400.jpg',
    ),
  ];
}
