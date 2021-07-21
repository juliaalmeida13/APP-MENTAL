import 'package:app_mental/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserApp? _userFromFirebaseUser(User? user) {
    return user != null ? UserApp(userId: user.uid) : null;
  }

  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserCredential?> signupWithEmailAndPasswordAndName(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        result.user!.updateDisplayName(name);
      }
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user as User;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
