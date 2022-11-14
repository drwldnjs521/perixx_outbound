import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perixx_outbound/Data/login/auth_exceptions.dart';
import 'package:perixx_outbound/Application/login/auth_service.dart';
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
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/perixx.png"),
                      ), //DecorationImage
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 400,
                    width: MediaQuery.of(context).size.width - 100,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 182, 182, 183),
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 23, 0, 25),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.emailAddress,
                                  key: const ValueKey(1),
                                  validator: (value) {
                                    if (!value!.contains("@perixx.com")) {
                                      return 'enter_valid_email'.tr;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _email = value!;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _email = value;
                                    });
                                  },
                                  style: const TextStyle(fontSize: 25),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFFB6C7D1),
                                    ),
                                    // enabledBorder: const OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     color: Color(0XFFA7BCC7),
                                    //   ),
                                    //   borderRadius: BorderRadius.all(
                                    //     Radius.circular(35),
                                    //   ),
                                    // ),
                                    border: InputBorder.none,
                                    hintText: "email".tr,
                                    hintStyle: const TextStyle(
                                      fontSize: 25,
                                      color: Color(0XFFA7BCC7),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(25, 5, 25, 0),
                                    // focusedBorder: const OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     color: Color(0XFFA7BCC7),
                                    //   ),
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(35)),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 23, 0, 25),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: _isObscure,
                                  key: const ValueKey(2),
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return "not_valid_password".tr;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _password = value!;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                  style: const TextStyle(fontSize: 25),
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
                                    // enabledBorder: const OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     color: Color(0XFFA7BCC7),
                                    //   ),
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(35)),
                                    // ),
                                    border: InputBorder.none,
                                    hintText: "password".tr,
                                    hintStyle: const TextStyle(
                                        fontSize: 25, color: Color(0XFFA7BCC7)),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(25, 5, 25, 0),
                                    // focusedBorder: const OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     color: Color(0XFFA7BCC7),
                                    //   ),
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(35)),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_tryValidation()) {
                        try {
                          await AuthService.firebase().logIn(
                            email: _email,
                            password: _password,
                          );
                          Get.toNamed(orderListRoute);
                        } on UserNotFoundAuthException catch (e) {
                          await showErrorDialog(
                            context,
                            "$e",
                          );
                        } on WrongPasswordAuthException catch (e) {
                          await showErrorDialog(
                            context,
                            "$e",
                          );
                        } on GenericAuthException catch (e) {
                          await showErrorDialog(
                            context,
                            "$e",
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width - 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.orange,
                              Colors.red,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                              color: const Color.fromARGB(255, 182, 182, 183),
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
