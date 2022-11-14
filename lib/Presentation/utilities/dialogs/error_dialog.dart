import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'error'.tr,
    content: text,
    optionsBuilder: () => {
      // 'OK': null,
    },
  );
}
