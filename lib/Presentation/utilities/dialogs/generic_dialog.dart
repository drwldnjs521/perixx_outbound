import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final T value = options[optionTitle];
            return TextButton(
              onPressed: () {
                if (value != null) {
                  Navigator.of(context).pop(value);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(optionTitle),
            );
          }).toList(),
        );
      });
}

Future<T?> showGenericDialogWithUserName<T>({
  required BuildContext context,
  required String title,
  required String userName,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: RichText(
            text: TextSpan(
                style: const TextStyle(
                  color: Color.fromARGB(213, 53, 51, 51),
                  fontSize: 20,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Hello, '),
                  TextSpan(
                    text: '$userName \n',
                    style: const TextStyle(
                      color: Color.fromARGB(153, 239, 102, 43),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: content,
                  ),
                ]),
          ),
          actions: options.keys.map((optionTitle) {
            final T value = options[optionTitle];
            return TextButton(
              onPressed: () {
                if (value != null) {
                  Navigator.of(context).pop(value);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(optionTitle),
            );
          }).toList(),
        );
      });
}
