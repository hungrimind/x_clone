import 'package:flutter/material.dart';
import 'package:x_clone/pages/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _signInKey = GlobalKey<FormState>();

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _signInKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/x.png'),
              width: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Log in to X',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (!emailValid.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 letters';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: TextButton(
                onPressed: () async {
                  if (_signInKey.currentState!.validate()) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Home()));
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Don\'t have an account? Sign up here',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
