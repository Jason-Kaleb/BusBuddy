import 'package:busbuddy/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showSuccessDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Success',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
