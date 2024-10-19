import 'package:busbuddy/constants/routes.dart';
import 'package:busbuddy/services/auth/auth_exceptions.dart';
import 'package:busbuddy/services/auth/auth_service.dart';
import 'package:busbuddy/utilities/dialogs/error_dialog.dart';
import 'package:busbuddy/views/register_view.dart';

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25.0),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                child: Image.asset(
                    "assets/images/undraw_Mobile_login_re_9ntv.png"),
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _email, // Use the controller here
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(217, 219, 219, 219),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Enter your email',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _password, // Use the controller here
                  autofocus: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(217, 219, 219, 219),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Enter your password',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(forgotPasswordRoute);
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  String email = _email.text;
                  String password = _password.text;

                  try {
                    await AuthService.firebase().logIn(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          mapsRoute,
                          (route) => false,
                        );
                      }
                    } else {
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyEmailRoute,
                          (route) => false,
                        );
                      }
                    }
                  } on UserNotFoundAuthException {
                    if (context.mounted) {
                      await showErrorDialog(
                        context,
                        'User not found',
                      );
                    }
                  } on WrongPasswordAuthException {
                    if (context.mounted) {
                      await showErrorDialog(
                        context,
                        'Wrong password',
                      );
                    }
                  } on GenericAuthException {
                    if (context.mounted) {
                      await showErrorDialog(
                        context,
                        'Authentication Error',
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 50),
                  backgroundColor: const Color(0xFFFF4500),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterView(),
                    ),
                  );
                },
                child: const Text(
                  'Don\'t have an account? Sign up!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
