import 'package:perixx_outbound/Data/auth_repository.dart';
import 'package:perixx_outbound/Domain/auth_user.dart';

class AuthService {
  final FirebaseAuthRepository repo;

  const AuthService(this.repo);
  factory AuthService.firebase() => AuthService(FirebaseAuthRepository());

  AuthUser? get currentUser => repo.currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      repo.logIn(
        email: email,
        password: password,
      );

  Future<void> logOut() => repo.logOut();

  Future<void> initialize() => repo.initialize();
}
