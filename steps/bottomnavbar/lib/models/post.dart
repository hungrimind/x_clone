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
      handle: '@cb_doge',
      verified: true,
      time: '1h',
      content: 'This is my first post on X\nHello world.',
      comments: '9.2K',
      reposts: '10.5K',
      likes: '116K',
      views: '11M',
      profilePictureUrl:
          'https://pbs.twimg.com/profile_images/1498070100393754625/C2V-fbll_400x400.jpg',
    ),
    Post(
      name: 'Michael Daly',
      handle: '@drmikeDO1943',
      verified: true,
      time: '3h',
      content:
          'A grandson just texted: How is X? Why do you think it\'s newsworthy? My answer: It is panoply of views/comments and it is continuously updated. You immerse yourself in the "town square" of discussion and come to your own conclusions about what is true.',
      comments: '3.2K',
      reposts: '454',
      likes: '113K',
      views: '14M',
      profilePictureUrl:
          'https://pbs.twimg.com/profile_images/1585715412116930561/CHkTz-aM_400x400.jpg',
    ),
    Post(
      name: 'Tadas Petra',
      handle: '@tadaspetra',
      verified: true,
      time: '5h',
      content: 'The X Clone I\'m building right now is looking so clean.',
      comments: '42',
      reposts: '15',
      likes: '203',
      views: '5.2K',
      profilePictureUrl:
          'https://pbs.twimg.com/profile_images/1799810491470028801/7hTyg0NP_400x400.jpg',
    ),
    Post(
      name: 'Robert',
      handle: '@RobertBrunhage',
      verified: false,
      time: '2h',
      content:
          'Hello, my name is Robert and I know how to post engaging content.',
      comments: '31',
      reposts: '22',
      likes: '178',
      views: '4.7K',
      profilePictureUrl:
          'https://pbs.twimg.com/profile_images/1364915715350888449/5LMWEACf_400x400.jpg',
    ),
    Post(
      name: 'Elon Musk',
      handle: '@elonmusk',
      verified: true,
      time: '30m',
      content:
          'Exciting progress on Starship! Next test flight coming soon. To Mars and beyond!',
      comments: '15.3K',
      reposts: '32.1K',
      likes: '301K',
      views: '25M',
      profilePictureUrl:
          'https://pbs.twimg.com/profile_images/1590968738358079488/IY9Gx6Ok_400x400.jpg',
    ),
  ];
}
