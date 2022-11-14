import 'package:flutter/material.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/generic_dialog.dart';
import 'package:get/get.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
  String userName,
) {
  return showGenericDialogWithUserName(
    context: context,
    title: 'Logout',
    userName: userName,
    content: 'check_logout'.tr,
    optionsBuilder: () => {
      'Cancel': false,
      'Logout': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
