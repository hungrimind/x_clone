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
              "https://picsum.photos/300/300",
            ),
          ),
        ),
      ),
      body: const Text('Home'),
    );
  }
}
