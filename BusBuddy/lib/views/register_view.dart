import 'package:busbuddy/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:busbuddy/views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Declare the TextEditingControllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Dispose the controllers when no longer needed
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Register', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              const Text(
                'Welcome Onboard',
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
                  controller: _fullNameController,
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
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Enter your full name',
                    labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Email Field
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _emailController,
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
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Enter your email',
                    labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Password Field
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _passwordController,
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
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Enter your password',
                    labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Confirm Password Field
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _confirmPasswordController,
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
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Confirm password',
                    labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),

              // Register Button
              TextButton(
                onPressed: () async {
                  String fullName = _fullNameController.text.trim();
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  String confirmPassword = _confirmPasswordController.text.trim();

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

                  await AuthService().signup(
                    fullName: fullName,
                    email: email,
                    password: password,
                  );
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
