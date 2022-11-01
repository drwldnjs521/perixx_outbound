import 'package:flutter/material.dart';
import 'package:perixx_outbound/Application/auth_exceptions.dart';
import 'package:perixx_outbound/Application/auth_service.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/error_dialog.dart';
import 'package:perixx_outbound/constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //declare a variable to keep track of the input text
  String _email = '';
  String _password = '';
  //declare a variable to hide and show the password
  bool _isObscure = true;
  //declare a Globalkey
  final _formkey = GlobalKey<FormState>();

  bool _tryValidation() {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/perixx.png"),
                    ), //DecorationImage
                  ), //BoxDecoration
                ), //Container
              ), //Positioned
              Positioned(
                top: 260,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 220,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(
                    //     color: Colors.indigo.shade900,
                    //     width: 1.0,
                    //     style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ), //BoxDecoration
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                const SizedBox(height: 13),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  key: const ValueKey(1),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains("@perixx.com")) {
                                      return "Please enter a valid email address!";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _email = value!;
                                  },
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFFB6C7D1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFFA7BCC7),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Color(0XFFA7BCC7)),
                                    contentPadding: EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFFA7BCC7),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  obscureText: _isObscure,
                                  key: const ValueKey(2),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return "Password must be at least 7 characters long!";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _password = value!;
                                  },
                                  onChanged: (value) {
                                    _password = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Color(0xFFB6C7D1),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFFA7BCC7),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                    ),
                                    hintText: "Password",
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Color(0XFFA7BCC7)),
                                    contentPadding: const EdgeInsets.all(10),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFFA7BCC7),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 450,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        if (_tryValidation()) {
                          try {
                            await AuthService.firebase().logIn(
                              email: _email,
                              password: _password,
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              orderListRoute,
                              (route) => false,
                            );
                          } on UserNotFoundAuthException catch (e) {
                            await showErrorDialog(
                              context,
                              "ERROR: ${e.toString().toUpperCase()}",
                            );
                          } on WrongPasswordAuthException catch (e) {
                            await showErrorDialog(
                              context,
                              "ERROR: ${e.toString().toUpperCase()}",
                            );
                          } on GenericAuthException catch (e) {
                            await showErrorDialog(
                              context,
                              "ERROR: ${e.toString().toUpperCase()}",
                            );
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                Colors.orange,
                                Colors.red,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
