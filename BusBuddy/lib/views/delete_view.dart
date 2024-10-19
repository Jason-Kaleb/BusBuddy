import 'package:busbuddy/constants/routes.dart';
import 'package:busbuddy/services/auth/auth_exceptions.dart';
import 'package:busbuddy/services/auth/auth_service.dart';
import 'package:busbuddy/utilities/dialogs/delete_with_password_dialog.dart';
import 'package:busbuddy/utilities/dialogs/error_dialog.dart';
import 'package:busbuddy/utilities/dialogs/password_not_entered_dialog.dart';
import 'package:flutter/material.dart';

class DeleteView extends StatefulWidget {
  const DeleteView({super.key});

  @override
  State<DeleteView> createState() => _DeleteViewState();
}

class _DeleteViewState extends State<DeleteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xFFFF4500),
                  size: 24,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF4500),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4500).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xFFFF4500),
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'We are really sorry to see you go 😢',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF4500),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Are you sure you want to delete your account with us? Once you confirm, all your data will be permanently deleted.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await onDeleteUserButtonPressed(context);
                  } on FailedToDeleteUserException {
                    if (context.mounted) {
                      await showErrorDialog(
                        context,
                        'Unable to delete user',
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

Future<void> onDeleteUserButtonPressed(BuildContext context) async {
  try {
    final password = await showPasswordPrompt(context);

    if (password != null && password.isNotEmpty) {
      await AuthService.firebase().deleteUser(password: password);

      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          loginRoute,
          (_) => false,
        );
      }
    } else {
      if (context.mounted) {
        showPasswordNotEnteredDialog(context, "No password was entered");
      }
    }
  } on WrongPasswordAuthException {
    if (context.mounted) {
      await showErrorDialog(
        context,
        'Incorrect password, Please enter your correct password to delete your account.',
      );
    }
  }
}
