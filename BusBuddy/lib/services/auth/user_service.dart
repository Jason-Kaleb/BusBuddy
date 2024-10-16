import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<String> getUserName() async {
    final user = _auth.currentUser;
    return user?.displayName ?? 'No Name';
  }

  Future<String> getUserEmail() async {
    final user = _auth.currentUser;
    return user?.email ?? 'No Email';
  }
}
