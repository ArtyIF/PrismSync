// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:prismsync/api/api.dart';
import 'package:prismsync/api/json/login_form.dart';
import 'package:prismsync/gallery.dart';
import 'package:prismsync/utilities.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _baseUrl = '';
  String _username = '';
  String _password = '';

  String? _valueNotNullOrEmpty(String? value) {
    return (value != null && value.isNotEmpty) ? null : 'Value cannot be empty';
  }

  String? _valueNotNull(String? value) {
    return (value != null) ? null : 'Value cannot be null';
  }

  void _logIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // TODO: allow going back and somehow cancel logging in
      // TODO: logging in is untested!!!
      showLoadingOverlay(context);
      String? error = await logIn(
        _baseUrl,
        LoginForm(
          username: _username,
          password: _password,
        ),
      );
      hideLoadingOverlay(context);

      if (!showSnackBarOnError(context, error)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GalleryPage(),
          ),
        );
      }
    } else {
      showSnackBar(
        context: context,
        text: 'Check the fields for errors',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrismSync Setup'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: kTabLabelPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  key: const Key('baseUrl'),
                  decoration: const InputDecoration(
                    hintText: 'Address',
                  ),
                  keyboardType: TextInputType.url,
                  validator: _valueNotNullOrEmpty,
                  onSaved: (value) {
                    _baseUrl = value!;
                  },
                ),
                TextFormField(
                  key: const Key('username'),
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                  autocorrect: false,
                  enableSuggestions: false,
                  validator: _valueNotNull,
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                TextFormField(
                  key: const Key('password'),
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  validator: _valueNotNull,
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(kMaterialListPadding.top),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: _logIn,
                      icon: const Icon(Icons.login),
                      label: const Text('Log In'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GalleryPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.cloud_off),
                      label: const Text('Use Offline'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
