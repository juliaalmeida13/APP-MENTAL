import 'package:app_mental/helper/helperfuncions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

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
