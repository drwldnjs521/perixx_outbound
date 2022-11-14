//login exceptions
import 'package:get/get.dart';

class UserNotFoundAuthException implements Exception {
  @override
  String toString() {
    return 'user_not_exists'.tr;
  }
}

class WrongPasswordAuthException implements Exception {
  @override
  String toString() {
    return 'wrong_password'.tr;
  }
}

//generic exceptions
class GenericAuthException implements Exception {
  @override
  String toString() {
    return 'process_failed'.tr;
  }
}
