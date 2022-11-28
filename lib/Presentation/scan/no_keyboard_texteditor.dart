import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWithoutKeyboard extends EditableText {
  TextFieldWithoutKeyboard({
    required TextEditingController controller,
    required TextStyle style,
    required Function onValueUpdated,
    required Color cursorColor,
    bool autofocus = false,
    required Color selectionColor,
  }) : super(
            controller: controller,
            maxLines: null,
            focusNode: TextfieldFocusNode(),
            style: style,
            cursorColor: cursorColor,
            autofocus: autofocus,
            selectionColor: selectionColor,
            backgroundCursorColor: Colors.black,
            onChanged: (value) {
              onValueUpdated(value);
            });

  @override
  EditableTextState createState() {
    return TextFieldEditableState();
  }
}

//This is to hide keyboard when user tap on textfield.
class TextFieldEditableState extends EditableTextState {
  @override
  void requestKeyboard() {
    super.requestKeyboard();
    //hide keyboard
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

// This hides keyboard from showing on first focus / autofocus
class TextfieldFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
//  Use this custom widget in your screen by replacing TextField //with, TextFieldWithNoKeyboard

//=====Below is example to use in your screen ==//

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  TextEditingController scanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextFieldWithoutKeyboard(
          controller: scanController,
          autofocus: true,
          cursorColor: Colors.green,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
          selectionColor: Colors.amber,
          onValueUpdated: (value) {
            print(value);
          },
        ),
      ),
    );
  }
}
