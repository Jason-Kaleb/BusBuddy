import 'package:busbuddy/services/auth/auth_exceptions.dart';
import 'package:busbuddy/services/auth/auth_provider.dart';
import 'package:busbuddy/services/auth/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });
    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test(
      'Create user should delegate to logIn function',
      () async {
        await provider.initialize();

        final badEmailUser = provider.createUser(
          fullName: '213123',
          email: 'invalid-email',
          password: 'helloworld',
        );

        expect(
          () async => badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()),
        );

        final badPasswordUser = provider.createUser(
          fullName: '213123',
          email: 'helloworld@.com',
          password: 'ab',
        );

        expect(
          () async => badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()),
        );

        final user = await provider.createUser(
          fullName: 'John Doe',
          email: 'john@example.com',
          password: 'validPassword',
        );

        expect(provider.currentUser, user);
        expect(user?.isEmailVerified, false);
      },
    );

    test('logged in user should be able to get verified', () async {
      await provider.initialize();

      await provider.logIn(
        email: 'HelloWorld@gmail.com',
        password: 'helloworld',
      );
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user?.isEmailVerified, true);
    });

    test('Should be able to log in and out again', () async {
      await provider.initialize();
      await provider.logOut();
      await provider.logIn(
        email: 'HelloWorld@gmail.com',
        password: 'helloworld',
      );

      final user = provider.currentUser;
      expect(user, isNotNull);
    });

    test('Should delete user', () async {
      await provider.initialize();

      await provider.logIn(
        email: 'HelloWorld@gmail.com',
        password: 'helloworld',
      );

      expect(provider.currentUser, isNotNull);

      await provider.deleteUser(password: 'userPassword');

      final user = provider.currentUser;

      expect(user, isNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser?> createUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    if (!email.contains('@') || !email.contains('.')) {
      throw UserNotFoundAuthException();
    }
    if (password.isEmpty || password.length < 3) {
      throw WrongPasswordAuthException();
    }

    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser?> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email != 'HelloWorld@gmail.com') throw UserNotFoundAuthException();
    if (password != 'helloworld') throw WrongPasswordAuthException();
    const user = AuthUser(
      isEmailVerified: false,
      email: 'hello@gmail.com',
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      isEmailVerified: true,
      email: 'HelloWorld@gmail.com',
    );
    _user = newUser;
    return Future.value();
  }

  @override
  Future<void> deleteUser({required String password}) async {
    if (_user == null) throw UserNotFoundAuthException();

    await Future.delayed(const Duration(seconds: 1));

    _user = null;
  }

  @override
  Future<void> resetPassword({required String email}) {
    throw UnimplementedError();
  }
}
