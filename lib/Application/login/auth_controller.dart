import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:perixx_outbound/Data/login/auth_exceptions.dart';
import 'package:perixx_outbound/Data/login/auth_repository.dart';
import 'package:perixx_outbound/Domain/login/auth_user.dart';
import 'package:perixx_outbound/Presentation/login/login_view.dart';
import 'package:perixx_outbound/Presentation/orderlist/order_view.dart';

class AuthController extends GetxController {
  late Rx<AuthUser?> _authUser;
  final AuthRepository _auth = AuthRepository.instance;

  @override
  void onReady() {
    _authUser = Rx<AuthUser?>(AuthRepository.instance.currentUser);
    _authUser.bindStream(AuthRepository.instance.changeUser());
    // ever(_authUser, _moveToPage);
  }

  @override
  void onClose() {}

  AuthUser? get currentUser => AuthRepository.instance.currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.logIn(
        email: email,
        password: password,
      );
      final user = currentUser;
      return user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw UserNotFoundAuthException();
      } else if (e.code == "wrong-password") {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future<void> logOut() async {
    AuthRepository.instance.logOut();
  }

  String? validateEmail(String value) {
    if (!value.contains("@perixx.com")) {
      return 'enter_valid_email'.tr;
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "not_valid_password".tr;
    }
    return null;
  }

  void _moveToPage(AuthUser? authUser) {
    if (authUser == null) {
      Get.offAll(() => const LoginView());
    } else {
      Get.offAll(() => const OrderView());
    }
  }
}
