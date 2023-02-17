import 'package:app_mental/helper/helperfuncions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class AuthMethods {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  // UserApp? _userFromFirebaseUser(User? user) {
  //   return user != null ? UserApp(userId: user.uid) : null;
  // }

  /*Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  /// Fetches user from Firebase and returns a promise
  /*Future<Map<String, dynamic>> fetchUser(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    final data = doc.data()!;

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

    return data;
  }

  Future<UserCredential?> signupWithEmailAndPasswordAndName(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        result.user!.updateDisplayName(name);
      }

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
            firstName: name,
            id: result.user!.uid,
            imageUrl: 'https://i.pravatar.cc/300',
            lastName: 'none',
            role: types.Role.user),
      );
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  // Future signUpWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User firebaseUser = result.user as User;
  //     return _userFromFirebaseUser(firebaseUser);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

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
