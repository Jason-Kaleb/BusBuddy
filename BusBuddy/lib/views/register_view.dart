import 'package:busbuddy/constants/routes.dart';
import 'package:busbuddy/services/auth/auth_exceptions.dart';
import 'package:busbuddy/services/auth/auth_service.dart';
import 'package:busbuddy/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:busbuddy/views/login_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Declare the TextEditingControllers
  late final TextEditingController _fullName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _fullName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 150.0),
              const Text(
                'Welcome Onboard, Register here!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Fill in the below in order to Register',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 52.0),

              // Full Name Field
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _fullName,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.grey),
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
                    labelText: 'Enter your full name',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Email Field
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.grey),
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
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Password Field
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
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
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Confirm Password Field
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _confirmPassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
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
                    labelText: 'Confirm password',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),

              // Register Button
              TextButton(
                onPressed: () async {
                  String fullName = _fullName.text.trim();
                  String email = _email.text.trim();
                  String password = _password.text.trim();
                  String confirmPassword = _confirmPassword.text.trim();

                  if (password != confirmPassword) {
                    Fluttertoast.showToast(
                      msg: 'Passwords do not match',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                    );
                    return;
                  }

                  try {
                    await AuthService.firebase().createUser(
                      fullName: fullName,
                      email: email,
                      password: password,
                    );
                    final User? user = FirebaseAuth.instance.currentUser;
                    if(user!=null){
                      DatabaseReference usersRef = FirebaseDatabase.instance.ref('users/${user.uid}');

                      await usersRef.set({
                        'fullName':fullName,
                        'email':email,
                        'uid':user.uid,
                        'points': 0,
                      });
                    }
                    AuthService.firebase().sendEmailVerification();
                    if (context.mounted) {
                      Navigator.of(context).pushNamed(
                        verifyEmailRoute,
                      );
                    }
                  } on EmailAlreadyInUseAuthException {
                    if (context.mounted) {
                      await showErrorDialog(
                        context,
                        "Email already in use",
                      );
                    }
                  } on InvalidEmailAuthException {
                    if (context.mounted) {
                      await showErrorDialog(
                        context,
                        "Invalid email",
                      );
                    }
                  } on WeakPasswordAuthException {
                    if (context.mounted) {
                      await showErrorDialog(
                        context,
                        "Password should be at least 6 characters",
                      );
                    }
                  } on GenericAuthException {
                    if (context.mounted) {
                      await showErrorDialog(
                        context,
                        "Something went wrong",
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
                  'REGISTER',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 30.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
                child: const Text(
                  'Already have an Account? Login Here!',
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
