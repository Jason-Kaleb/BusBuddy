import 'package:busbuddy/services/auth/auth_exceptions.dart';
import 'package:busbuddy/services/auth/auth_service.dart';
import 'package:busbuddy/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              autofocus: false,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                alignLabelWithHint: true,
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
                labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                try {
                  if (email.isNotEmpty) {
                    await AuthService.firebase().resetPassword(email: email);
                  } else {
                    await showErrorDialog(
                        context, 'Please enter a valid email');
                  }
                } on UserNotFoundAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'User not found',
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
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
