import 'package:http/http.dart' as http;

class UserService {
  Future<http.Response?> signupWithEmailAndPasswordAndName(
      String name, String email, String password) async {
    return http.get(Uri.parse('http://localhost:8080//sample'));

    // try {
    //   UserCredential result = await _auth.createUserWithEmailAndPassword(
    //       email: email, password: password);
    //   if (result.user != null) {
    //     result.user!.updateDisplayName(name);
    //   }

    //   await FirebaseChatCore.instance.createUserInFirestore(
    //     types.User(
    //         firstName: name,
    //         id: result.user!.uid,
    //         imageUrl: 'https://i.pravatar.cc/300',
    //         lastName: 'none',
    //         role: types.Role.user),
    //   );
    //   return result;
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }
}
