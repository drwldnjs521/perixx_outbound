import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Data/login/auth_exceptions.dart';
import 'package:perixx_outbound/Application/login/auth_controller.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';
import 'package:perixx_outbound/Presentation/utilities/dialogs/error_dialog.dart';

//GetView is a const Stateless Widget that has a getter controller for a registered Controller, that's all.
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authController = Get.find<AuthController>();
  final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isObscure = true;

  bool _tryValidation() {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    //screenwidth = 800
    //screenwidth = 1232
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: SizeConfig.safeVertical * 0.2,
                    width: SizeConfig.safeHorizontal * 0.8,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/perixx.png"),
                        fit: BoxFit.fill,
                      ), //DecorationImage
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeVertical * 0.02,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: SizeConfig.safeVertical * 0.25,
                    width: SizeConfig.screenWidth * 0.82,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
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
                          SizedBox(
                            height: SizeConfig.safeVertical * 0.025,
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
                                  autovalidateMode: AutovalidateMode.disabled,
                                  keyboardType: TextInputType.emailAddress,
                                  key: const ValueKey(1),
                                  validator: (value) {
                                    if (value != null) {
                                      return authController
                                          .validateEmail(value);
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
                                  style: const TextStyle(fontSize: 35),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      fontSize: 20,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFFB6C7D1),
                                      size: 35,
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
                                      fontSize: 35,
                                      color: Color(0XFFA7BCC7),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(25, 5, 25, 5),
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
                          SizedBox(
                            height: SizeConfig.safeVertical * 0.03,
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
                                    const EdgeInsets.fromLTRB(20, 23, 20, 25),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.disabled,
                                  obscureText: _isObscure,
                                  key: const ValueKey(2),
                                  validator: (value) {
                                    if (value != null) {
                                      return authController
                                          .validatePassword(value);
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
                                  style: const TextStyle(fontSize: 35),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      fontSize: 20,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Color(0xFFB6C7D1),
                                      size: 35,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      iconSize: 35,
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    border: InputBorder.none,
                                    hintText: "password".tr,
                                    hintStyle: const TextStyle(
                                        fontSize: 35, color: Color(0XFFA7BCC7)),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(25, 5, 25, 5),
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
                SizedBox(
                  height: SizeConfig.safeVertical * 0.022,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_tryValidation()) {
                      try {
                        await authController.logIn(
                          email: _email,
                          password: _password,
                        );
                        Get.offNamed('/ORDERLIST');
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Center(
                      child: Container(
                        height: SizeConfig.screenHeight * 0.066,
                        width: SizeConfig.screenWidth * 0.82,
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
                        child: Center(
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.notoSans(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
      ),
    );
  }
}
