import 'dart:convert';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_mental/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import '../helper/helperfuncions.dart';
import '../model/user_profile.dart';

final String url = dotenv.env['BACKEND_URL']!;

class UserService {
  Future<UserApp> signupWithEmailAndPasswordAndName(
      String email, String name, String password) async {
    final response = await http.post(Uri.parse("${url}createAppUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'name': name,
          'password': md5.convert(utf8.encode(password)).toString(),
          'imageUrl': 'https://i.pravatar.cc/300'
        }));
    if (response.statusCode == 200) {
      return UserApp.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<UserApp> signIn(String email, String password) async {
    final response = await http.post(Uri.parse("${url}loginApp"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': md5.convert(utf8.encode(password)).toString(),
        }));
    if (response.statusCode == 200) {
      return UserApp.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<bool> signOut() async {
    return HelperFunctions.clearUserInSharedPreference();
  }

  Future<void> resetPassword(String email) async {
    final response = await http.post(Uri.parse("${url}recoveryEmail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<void> saveUserProfile(
      String email,
      String name,
      String gender,
      String age,
      String workplace,
      String maritalStatus,
      String occupation,
      String phone) async {
    final response = await http.post(Uri.parse("${url}saveUserProfile"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'name': name,
          'gender': gender,
          'age': age,
          'workplace': workplace,
          'maritalStatus': maritalStatus,
          'occupation': occupation,
          'phone': phone
        }));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<UserProfile> getUserProfile(String email) async {
    final response = await http.get(
        Uri.parse("${url}getUserProfile?email=$email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) != "") {
        return UserProfile.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        return UserProfile();
      }
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
