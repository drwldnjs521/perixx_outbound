import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  if (options.isNotEmpty) {
    return Get.dialog(
      AlertDialog(
        title: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return SizedBox(
              height: height - 900,
              width: width - 400,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 140,
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                      color: Color.fromARGB(213, 53, 51, 51),
                      fontSize: 30,
                    ),
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
              padding: const EdgeInsets.all(15),
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
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          );
        }).toList(),
        actionsOverflowButtonSpacing: 20,
        actionsPadding: const EdgeInsets.fromLTRB(30, 20, 30, 100),
        actionsAlignment: MainAxisAlignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  } else {
    return Get.dialog(
      AlertDialog(
        title: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return SizedBox(
              height: height - 900,
              width: width - 400,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 140,
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                      color: Color.fromARGB(213, 53, 51, 51),
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
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
  final options = optionsBuilder();
  return Get.dialog(
    AlertDialog(
      title: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            height: height - 900,
            width: width - 400,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 140,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Color.fromARGB(213, 53, 51, 51),
                      fontSize: 30,
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
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {
            if (value != null) {
              // Navigator.of(context).pop(value);
              Get.back(result: value);
            } else {
              // Navigator.of(context).pop();
              Get.back();
            }
          },
          child: Text(
            optionTitle,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        );
      }).toList(),
      actionsOverflowButtonSpacing: 20,
      actionsPadding: const EdgeInsets.fromLTRB(30, 20, 30, 100),
      actionsAlignment: MainAxisAlignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );
}
