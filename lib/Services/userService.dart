import 'dart:convert';

import 'package:app_mental/model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserApp> signupWithEmailAndPasswordAndName(
      String name, String email, String password) async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8080/createAppUser'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'name': name,
              'password': password,
              'imageUrl': 'https://i.pravatar.cc/300'
            }));

    if (response.statusCode == 200) {
      return UserApp.fromJson(jsonDecode(response.body));
    }
    throw Exception("Erro ao criar o usuário");
  }
}
