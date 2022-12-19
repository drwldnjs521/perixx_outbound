import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  SizeConfig.init(context);
  final options = optionsBuilder();
  if (options.isNotEmpty) {
    return Get.dialog(
      AlertDialog(
        titlePadding: EdgeInsets.symmetric(
          vertical: SizeConfig.safeVertical * 0.08,
          horizontal: SizeConfig.safeHorizontal * 0.05,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeVertical * 0.04,
            color: const Color.fromARGB(186, 54, 54, 54),
          ),
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.only(
          left: SizeConfig.safeHorizontal * 0.13,
          right: SizeConfig.safeHorizontal * 0.13,
          bottom: SizeConfig.safeHorizontal * 0.13,
        ),
        content: Builder(
          builder: (context) {
            return Text(
              content,
              style: TextStyle(
                color: const Color.fromARGB(213, 53, 51, 51),
                fontSize: SizeConfig.safeVertical * 0.028,
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
        actions: options.keys.map((optionTitle) {
          final T value = options[optionTitle];
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              // padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              if (value != null) {
                Get.back(result: value);
              } else {
                Get.back();
              }
            },
            child: Text(
              optionTitle,
              style: TextStyle(
                fontSize: SizeConfig.safeVertical * 0.02,
              ),
            ),
          );
        }).toList(),
        actionsOverflowButtonSpacing: 20,
        actionsPadding: EdgeInsets.fromLTRB(
          SizeConfig.safeHorizontal * 0.08,
          0,
          SizeConfig.safeHorizontal * 0.08,
          SizeConfig.safeHorizontal * 0.09,
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
      ),
    );
  } else {
    return Get.dialog(
      AlertDialog(
        titlePadding: EdgeInsets.symmetric(
          vertical: SizeConfig.safeVertical * 0.08,
          horizontal: SizeConfig.safeHorizontal * 0.05,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.safeVertical * 0.04,
              color: const Color.fromARGB(225, 255, 23, 23)),
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.only(
          left: SizeConfig.safeHorizontal * 0.13,
          right: SizeConfig.safeHorizontal * 0.13,
          bottom: SizeConfig.safeHorizontal * 0.13,
        ),
        content: Builder(
          builder: (context) {
            return Text(
              content,
              style: TextStyle(
                color: const Color.fromARGB(213, 53, 51, 51),
                fontSize: SizeConfig.safeVertical * 0.028,
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
      ),
    );
  }
}

Future<T?> showGenericDialogWithUserName<T>({
  required BuildContext context,
  required String title,
  required String userName,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  SizeConfig.init(context);
  final options = optionsBuilder();

  return Get.dialog(
    AlertDialog(
      titlePadding: EdgeInsets.all(SizeConfig.safeHorizontal * 0.1),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.safeVertical * 0.045,
          color: const Color.fromARGB(186, 54, 54, 54),
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.only(
        left: SizeConfig.safeHorizontal * 0.13,
        right: SizeConfig.safeHorizontal * 0.13,
        bottom: SizeConfig.safeHorizontal * 0.13,
      ),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: const Color.fromARGB(213, 53, 51, 51),
                fontSize: SizeConfig.safeVertical * 0.028,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'greeting'.tr,
                ),
                const TextSpan(
                  text: ', ',
                ),
                TextSpan(
                  text: '$userName \n',
                  style: const TextStyle(
                    color: Color.fromARGB(164, 247, 64, 14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: content,
                ),
              ],
            ),
          );
        },
      ),
      actions: options.keys.map((optionTitle) {
        final T value = options[optionTitle];
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            // padding: EdgeInsets.all(
            //   SizeConfig.safeHorizontal * 0.001,
            // ),
          ),
          onPressed: () {
            if (value != null) {
              Get.back(result: value);
            } else {
              Get.back();
            }
          },
          child: Text(
            optionTitle,
            style: TextStyle(
              fontSize: SizeConfig.safeVertical * 0.02,
            ),
          ),
        );
      }).toList(),
      actionsOverflowButtonSpacing: 20,
      actionsPadding: EdgeInsets.fromLTRB(
        SizeConfig.safeHorizontal * 0.08,
        0,
        SizeConfig.safeHorizontal * 0.08,
        SizeConfig.safeHorizontal * 0.09,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
    ),
  );
}
