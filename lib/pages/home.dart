import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
        title: const Image(
          image: AssetImage('assets/x.png'),
          width: 50,
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: const NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
                ),
                onBackgroundImageError: (exception, stackTrace) {},
              ),
            ),
          );
        }),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
        itemCount: 10,
        itemBuilder: (context, count) {
          return const ListTile(
            leading: CircleAvatar(
              foregroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
              ),
            ),
            title: Text(
              "Tadas",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Hello, this is a test tweet",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
      drawer: Drawer(
          child: Column(
        children: [
          Image.network(
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
          ),
          const ListTile(
            title: Text(
              "Hello, Tadas",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ListTile(
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Sign Out"),
            onTap: () {},
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
