import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';

import 'dart:convert';

import '../model/contact.dart';

final String url = dotenv.env['BACKEND_URL']!;

class ContactService {
  Future<List<Contact>> findContactByUser(String email) async {
    final response = await http.get(
        Uri.parse("${url}listContacts?email=${email}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(utf8.decode(response.bodyBytes));
      return List<Contact>.from(
          iterable.map((contact) => Contact.fromJson(contact)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<void> saveContact(String name, String number, String email) async {
    final response = await http.post(Uri.parse("${url}saveContact"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'email': email, 'name': name, 'number': number}));

    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<void> deleteContact(int idContact, String email) async {
    final response = await http.post(Uri.parse("${url}deleteContact"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'idContact': idContact.toString(),
          'email': email
        }));

    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<void> editContact(
      int idContact, String email, String name, String number) async {
    final response = await http.post(Uri.parse("${url}editContact"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'idContact': idContact.toString(),
          'email': email,
          'name': name,
          'number': number
        }));

    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }
}
