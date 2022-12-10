import 'package:get/get.dart';

class DuplicateException implements Exception {
  @override
  String toString() {
    return 'duplicate_exception'.tr;
  }
}

class MySqlCustomException implements Exception {
  final String message;
  MySqlCustomException(this.message);

  @override
  String toString() {
    return message;
  }
}
