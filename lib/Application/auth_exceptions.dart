//login exceptions
class UserNotFoundAuthException implements Exception {
  @override
  String toString() {
    return "User Not Found";
  }
}

class WrongPasswordAuthException implements Exception {
  @override
  String toString() {
    return "Wrong Password";
  }
}

//generic exceptions
class GenericAuthException implements Exception {
  @override
  String toString() {
    return "Failed to process";
  }
}

class UserNotLoggedInAuthExeption implements Exception {
  @override
  String toString() {
    return "User Not Logged In";
  }
}
