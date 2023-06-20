import 'dart:convert';

import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:app_mental/model/user.dart';
import 'package:crypto/crypto.dart';

import '../helper/helperfuncions.dart';
import 'api.dart';

class UserService {
  Future<UserApp> signupWithEmailAndPasswordAndName(
      String email, String name, String password) async {
    final response = await Api().post(
        "createAppUser",
        jsonEncode(<String, String>{
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

  Future<UserApp> signIn(String email, String password, String token) async {
    final response = await Api().post(
        "loginApp",
        jsonEncode(<String, String>{
          'email': email,
          'password': md5.convert(utf8.encode(password)).toString(),
          'token': token
        }));
    if (response.statusCode == 200) {
      return UserApp.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<bool> signOut() async {
    HelperFunctions.clearJwtInSharedPreference();
    return HelperFunctions.clearUserInSharedPreference();
  }

  Future<void> resetPassword(String email) async {
    final response = await Api()
        .post("recoveryEmail", jsonEncode(<String, String>{'email': email}));
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
    final response = await Api().post(
        "saveUserApp",
        jsonEncode(<String, String>{
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

  Future<UserApp> getUserApp(String email) async {
    final response = await Api().get("getUserApp?email=$email");
    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) != "") {
        return UserApp.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        return UserApp();
      }
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<String> getUserAvatar(String email) async {
    final response = await Api().get("getUserAvatar?email=$email");
    if (response.statusCode == 200) {
      return response.body;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<void> saveUserAvatar(String email, String imageUrl) async {
    final response = await Api().post(
        "saveUserAvatar",
        jsonEncode(<String, String>{
          'email': email,
          'image': imageUrl,
        }));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }
}
