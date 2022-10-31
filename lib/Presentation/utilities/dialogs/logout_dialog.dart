import 'package:flutter/material.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
  String userName,
) {
  return showGenericDialogWithUserName(
    context: context,
    title: 'LOGOUT',
    userName: userName,
    content: 'ARE YOU SURE YOU WANT TO LOG OUT?',
    optionsBuilder: () => {
      'CANCEL': false,
      'LOGOUT': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
