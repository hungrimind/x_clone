import 'package:flutter/material.dart';
import 'package:x_clone/models/tweet.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Container(
            margin: const EdgeInsets.only(left: 20),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://pbs.twimg.com/profile_images/1799810491470028801/7hTyg0NP_400x400.jpg",
              ),
            ),
          ),
          title: Image.asset(
            'assets/x-logo.png',
            width: 30,
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        body: const TabBarView(
          children: [
            TweetList(),
            Center(child: Text('Following Tab Content')),
            Center(child: Text('Subscribed Tab Content')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          iconSize: 36,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_outline), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: ''),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TweetList extends StatelessWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Tweet.sampleTweets.length,
      itemBuilder: (context, index) {
        return TweetCard(tweet: Tweet.sampleTweets[index]);
      },
    );
  }
}

class TweetCard extends StatelessWidget {
  final Tweet tweet;

  const TweetCard({super.key, required this.tweet});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey.shade800, width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(tweet.profilePictureUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(tweet.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 2),
                      if (tweet.verified)
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 16,
                        ),
                      const SizedBox(width: 2),
                      Text(tweet.handle,
                          style: const TextStyle(color: Colors.grey)),
                      const Text(' · ', style: TextStyle(color: Colors.grey)),
                      Text(tweet.time,
                          style: const TextStyle(color: Colors.grey)),
                      const Spacer(),
                      const Icon(Icons.more_horiz, color: Colors.grey),
                    ],
                  ),
                  Text(tweet.content),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconWithText(
                          icon: Icons.chat_bubble_outline,
                          text: tweet.comments),
                      IconWithText(icon: Icons.repeat, text: tweet.retweets),
                      IconWithText(
                          icon: Icons.favorite_border, text: tweet.likes),
                      IconWithText(icon: Icons.bar_chart, text: tweet.views),
                      const Icon(Icons.file_upload_outlined,
                          color: Colors.grey, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconWithText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 18),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
}
