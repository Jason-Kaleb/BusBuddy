import 'package:flutter/material.dart';

Future<String?> showPasswordPrompt(BuildContext context) async {
  String? password;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Password'),
        content: TextField(
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
          decoration: const InputDecoration(hintText: 'Enter your password'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );

  return password;
}
