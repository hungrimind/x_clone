import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
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
            dividerHeight: 0,
            tabs: [
              Tab(text: 'For you'),
              Tab(text: 'Following'),
              Tab(text: 'Subscribed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTweetList(),
            const Center(
                child: Text('Following Tab Content',
                    style: TextStyle(color: Colors.white))),
            const Center(
                child: Text('Subscribed Tab Content',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          iconSize: 36,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.mail), label: ''),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTweetList() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildTweetCard(index);
      },
    );
  }

  Widget _buildTweetCard(int index) {
    // Sample tweet data
    final tweets = [
      {
        'name': 'DogeDesigner',
        'handle': '@cb_doge',
        'verified': true,
        'time': '1h',
        'content': 'This is my first post on X\nHello world.',
        'comments': '9.2K',
        'retweets': '10.5K',
        'likes': '116K',
        'views': '11M',
      },
      {
        'name': 'Michael Daly',
        'handle': '@drmikeDO1943',
        'verified': true,
        'time': '3h',
        'content':
            'A grandson just texted: How is X? Why do you think it\'s newsworthy? My answer: It is panoply of views/comments and it is continuously updated. You immerse yourself in the "town square" of discussion and come to your own conclusions about what is true.',
        'comments': '3.2K',
        'retweets': '454',
        'likes': '113K',
        'views': '14M',
      },
      // Add more tweet data as needed
    ];

    if (index >= tweets.length) return const SizedBox.shrink();

    final tweet = tweets[index];

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
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(tweet['name'] as String,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      if (tweet['verified'] == true)
                        const Icon(Icons.verified,
                            color: Colors.blue, size: 16),
                      const SizedBox(width: 4),
                      Text(tweet['handle'] as String,
                          style: const TextStyle(color: Colors.grey)),
                      const Text(' · ', style: TextStyle(color: Colors.grey)),
                      Text(tweet['time'] as String,
                          style: const TextStyle(color: Colors.grey)),
                      const Spacer(),
                      const Icon(Icons.more_horiz, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(tweet['content'] as String,
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconWithText(Icons.chat_bubble_outline,
                          tweet['comments'] as String),
                      _buildIconWithText(
                          Icons.repeat, tweet['retweets'] as String),
                      _buildIconWithText(
                          Icons.favorite_border, tweet['likes'] as String),
                      _buildIconWithText(
                          Icons.bar_chart, tweet['views'] as String),
                      const Icon(Icons.share_outlined,
                          color: Colors.grey, size: 16),
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

  Widget _buildIconWithText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
