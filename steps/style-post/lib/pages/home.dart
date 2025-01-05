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
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(post.profilePictureUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(post.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 2),
                    if (post.verified)
                      const Icon(Icons.verified, color: Colors.blue),
                    const SizedBox(width: 2),
                    Text("${post.handle} • ${post.time}",
                        style: const TextStyle(color: Colors.grey)),
                    const Spacer(),
                    const Icon(Icons.more_horiz),
                  ],
                ),
                Text(post.content),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.comments,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ]),
                    Row(children: [
                      const Icon(
                        Icons.repeat,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.reposts,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ]),
                    Row(children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.likes,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ]),
                    Row(children: [
                      const Icon(
                        Icons.bar_chart,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.views,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ]),
                    const Icon(
                      Icons.file_upload_outlined,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
