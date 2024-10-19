import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser?> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser?> createUser({
    required String fullName,
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> deleteUser({required String password});
  Future<void> resetPassword({required String email});
  Future<void> sendEmailVerification();
}
