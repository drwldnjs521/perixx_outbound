import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String? email;
  final String? userName;

  const AuthUser({
    required this.email,
    required this.userName,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        email: user.email,
        userName: user.displayName,
      );
}
