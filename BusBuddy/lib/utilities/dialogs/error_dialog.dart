import 'package:busbuddy/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'An error has occurred',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
