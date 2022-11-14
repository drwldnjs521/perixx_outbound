import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:perixx_outbound/Data/login/auth_exceptions.dart';
import 'package:perixx_outbound/Domain/login/auth_user.dart';
import 'package:perixx_outbound/firebase_options.dart';

class FirebaseAuthRepository {
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.displayName == null) {
        _updateUserName(user);
      }
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
    FirebaseAuth.instance.signOut();
  }

  Future<void> _updateUserName(User user) async {
    final userName = user.email!.split("@")[0];
    await user.updateDisplayName(userName);
  }

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
