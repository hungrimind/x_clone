import 'package:flutter/material.dart';
import 'package:x_clone/pages/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SignIn(),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
