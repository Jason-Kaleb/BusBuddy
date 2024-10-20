import 'package:busbuddy/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showPasswordNotEnteredDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Not Entered',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
