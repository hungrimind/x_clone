import 'package:demo/models/post.dart';
import 'package:flutter/material.dart';

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
              backgroundImage: NetworkImage(
                "https://picsum.photos/300/300",
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
            const Text('For you Tab'),
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
    return Container();
  }
}
