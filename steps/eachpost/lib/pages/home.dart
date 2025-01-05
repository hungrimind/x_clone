import 'package:flutter/material.dart';

import '../models/post.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/x-logo.png",
            width: 30,
          ),
          leading: const Center(
            child: CircleAvatar(
              radius: 15,
              foregroundImage: NetworkImage(
                "https://pbs.twimg.com/profile_images/1799810491470028801/7hTyg0NP_400x400.jpg",
              ),
            ),
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            dividerHeight: 0.5,
            dividerColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'For you'),
              Tab(text: 'Following'),
              Tab(text: 'Subscribed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: Post.samplePosts.length,
              itemBuilder: (context, index) {
                return PostEntry(post: Post.samplePosts[index]);
              },
            ),
            const Text('Following Tab'),
            const Text('Subscribed Tab'),
          ],
        ),
      ),
    );
  }
}

class PostEntry extends StatelessWidget {
  final Post post;

  const PostEntry({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(post.content),
    );
  }
}
