import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: const Text('Home'),
    );
  }
}
