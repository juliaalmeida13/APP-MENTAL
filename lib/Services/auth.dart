import 'package:app_mental/helper/helperfuncions.dart';

class AuthMethods {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  Future resetPass(String email) async {
    try {
      return false; //await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return HelperFunctions.clearUserInSharedPreference();
    } catch (e) {
      print(e.toString());
    }
  }
}
