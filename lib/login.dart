import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              key: const Key('address'),
              decoration: const InputDecoration(
                hintText: 'Address',
              ),
            ),
            TextFormField(
              key: const Key('login'),
              decoration: const InputDecoration(
                hintText: 'Login',
              ),
            ),
            TextFormField(
              key: const Key('password'),
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.login),
              label: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
