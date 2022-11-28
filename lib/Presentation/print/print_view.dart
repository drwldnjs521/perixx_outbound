import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PrintView extends StatefulWidget {
  const PrintView({super.key});

  @override
  State<PrintView> createState() => _PrintViewState();
}

class _PrintViewState extends State<PrintView> {
  final TextEditingController _textController = TextEditingController();
  String _scannedEan = '';
  final List<String> _eanList = [];
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Scaffold(
      body: Center(
        // child: TextFieldWithoutKeyboard(
        //   controller: scanController,
        //   autofocus: true,
        //   cursorColor: Colors.green,
        //   style: const TextStyle(
        //     color: Colors.black,
        //     fontSize: 30,
        //   ),
        //   selectionColor: Colors.amber,
        //   onValueUpdated: (value) {
        //     print(value);
        //   },
        // ),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: _textController,
                decoration: const InputDecoration(
                  icon: FaIcon(
                    FontAwesomeIcons.searchengin,
                    size: 50,
                  ),
                ),
                style: GoogleFonts.notoSans(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    _scannedEan = value;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _eanList.add(_scannedEan);
                    _textController.clear();
                  });
                },
                child: const Text('ENTER'),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: SizedBox(
                  width: 800,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _eanList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          '${_eanList[index]} ',
                          style: GoogleFonts.notoSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
