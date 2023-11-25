import 'package:flutter/material.dart';
import 'package:prismsync/gallery.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO: make it look nice
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PrismSync Setup"),
      ),
      body: Center(
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
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: actually log in
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GalleryPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.login),
                label: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
