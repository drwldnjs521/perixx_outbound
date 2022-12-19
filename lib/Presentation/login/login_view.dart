import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Application/login/auth_controller.dart';
import 'package:perixx_outbound/Data/login/auth_exceptions.dart';
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
    // debugPrint(SizeConfig.screenWidth.toString());
    // debugPrint(SizeConfig.screenHeight.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: SizeConfig.safeVertical * 0.15,
            left: SizeConfig.safeHorizontal * 0.1,
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
          Positioned(
            top: SizeConfig.safeVertical * 0.4,
            left: SizeConfig.safeHorizontal * 0.05,
            child: Container(
              padding: EdgeInsets.all(SizeConfig.safeVertical * 0.009),
              height: SizeConfig.safeVertical * 0.3,
              width: SizeConfig.safeHorizontal * 0.9,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          SizeConfig.safeHorizontal * 0.015,
                          SizeConfig.safeVertical * 0.02,
                          SizeConfig.safeHorizontal * 0.015,
                          SizeConfig.safeVertical * 0.01,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              SizeConfig.safeHorizontal * 0.02,
                              SizeConfig.safeVertical * 0.02,
                              SizeConfig.safeHorizontal * 0.01,
                              SizeConfig.safeVertical * 0.02,
                            ),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.disabled,
                              keyboardType: TextInputType.emailAddress,
                              key: const ValueKey(1),
                              validator: (value) {
                                if (value != null) {
                                  return authController.validateEmail(value);
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
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth * 0.05),
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: SizeConfig.screenWidth * 0.04,
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: const Color.fromARGB(255, 7, 100, 198),
                                  size: SizeConfig.screenWidth * 0.06,
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
                                hintStyle: TextStyle(
                                  fontSize: SizeConfig.screenWidth * 0.05,
                                  color: const Color(0XFFA7BCC7),
                                ),
                                // contentPadding: EdgeInsets.fromLTRB(
                                //   SizeConfig.safeHorizontal * 0.01,
                                //   SizeConfig.safeVertical * 0.01,
                                //   SizeConfig.safeHorizontal * 0.01,
                                //   SizeConfig.safeVertical * 0.028,
                                // ),
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          SizeConfig.safeHorizontal * 0.015,
                          SizeConfig.safeVertical * 0.01,
                          SizeConfig.safeHorizontal * 0.015,
                          SizeConfig.safeVertical * 0.01,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              SizeConfig.safeHorizontal * 0.02,
                              SizeConfig.safeVertical * 0.02,
                              SizeConfig.safeHorizontal * 0.01,
                              SizeConfig.safeVertical * 0.02,
                            ),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.disabled,
                              obscureText: _isObscure,
                              key: const ValueKey(2),
                              validator: (value) {
                                if (value != null) {
                                  return authController.validatePassword(value);
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
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth * 0.05),
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: SizeConfig.screenWidth * 0.04,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color:
                                      const Color.fromARGB(255, 16, 154, 234),
                                  size: SizeConfig.screenWidth * 0.06,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(169, 212, 88, 0),
                                  ),
                                  iconSize: SizeConfig.screenWidth * 0.06,
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                hintText: "password".tr,
                                hintStyle: TextStyle(
                                    fontSize: SizeConfig.screenWidth * 0.05,
                                    color: const Color(0XFFA7BCC7)),
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
          Positioned(
            top: SizeConfig.safeVertical * 0.7,
            left: SizeConfig.safeHorizontal * 0.03,
            child: TextButton(
              onPressed: () async {
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
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.safeVertical * 0.02),
                height: SizeConfig.safeVertical * 0.065,
                width: SizeConfig.safeHorizontal * 0.9,
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
                      fontSize: SizeConfig.screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
