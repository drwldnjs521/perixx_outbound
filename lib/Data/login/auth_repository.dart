import 'package:firebase_auth/firebase_auth.dart';
import 'package:perixx_outbound/Domain/login/auth_user.dart';

class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();
  AuthRepository._internal();
  final FirebaseAuth _firestore = FirebaseAuth.instance;

  AuthUser? get currentUser {
    final user = _firestore.currentUser;
    if (user != null) {
      if (user.displayName == null) {
        _updateUserName(user);
      }
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  Stream<AuthUser?> changeUser() {
    return _firestore
        .userChanges()
        .map(
            (user) => AuthUser(email: user?.email, userName: user?.displayName))
        .asBroadcastStream();
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
    } catch (_) {
      rethrow;
    }
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == "user-not-found") {
    //     throw UserNotFoundAuthException();
    //   } else if (e.code == "wrong-password") {
    //     throw WrongPasswordAuthException();
    //   } else {
    //     throw GenericAuthException();
    //   }
    // } catch (_) {
    //   throw GenericAuthException();
    // }
  }

  Future<void> logOut() async {
    _firestore.signOut();
  }

  Future<void> _updateUserName(User user) async {
    final userName = user.email!.split("@")[0];
    await user.updateDisplayName(userName);
  }

  // Future<void> initialize() async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
}
