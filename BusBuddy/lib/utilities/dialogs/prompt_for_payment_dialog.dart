import 'package:flutter/material.dart';

Future<int?> promptForPayment(
    BuildContext context, String merchantDisplayName) async {
  final TextEditingController amountController = TextEditingController();

  final amount = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Enter Amount"),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Amount (ZAR)",
            prefixText: "R ",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final enteredAmount = int.tryParse(amountController.text);
              if (enteredAmount != null && enteredAmount > 0) {
                Navigator.of(context).pop(enteredAmount);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter a valid amount")),
                );
              }
            },
            child: const Text("Pay"),
          ),
        ],
      );
    },
  );

  return amount;
}
