import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Ошибка при регистрации: $e");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Ошибка при входе: $e");
    }
    return null;
  }

  String? getCurrentUserEmail() {
    try {
      User? user = _auth.currentUser;
      return user?.email;
    } catch (e) {
      print("Ошибка при получении электронной почты пользователя: $e");
    }
    return null;
  }
}
