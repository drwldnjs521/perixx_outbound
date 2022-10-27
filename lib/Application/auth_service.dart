import 'package:perixx_outbound/Data/auth_repository.dart';
import 'package:perixx_outbound/Domain/auth_user.dart';

class AuthService {
  final FirebaseAuthRepository firebaseRepo;

  const AuthService(this.firebaseRepo);

  factory AuthService.firebase() => AuthService(FirebaseAuthRepository());

  AuthUser? get currentUser => firebaseRepo.currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      firebaseRepo.logIn(
        email: email,
        password: password,
      );

  Future<void> logOut() => firebaseRepo.logOut();

  Future<void> initialize() async {
    await firebaseRepo.initialize();
  }
}
