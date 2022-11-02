import 'package:perixx_outbound/Data/login/auth_repository.dart';
import 'package:perixx_outbound/Domain/login/auth_user.dart';

class AuthService {
  final FirebaseAuthRepository _firebaseRepo;

  const AuthService(this._firebaseRepo);

  factory AuthService.firebase() => AuthService(FirebaseAuthRepository());

  AuthUser? get currentUser => _firebaseRepo.currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      _firebaseRepo.logIn(
        email: email,
        password: password,
      );

  Future<void> logOut() => _firebaseRepo.logOut();

  Future<void> initialize() async {
    await _firebaseRepo.initialize();
  }
}
