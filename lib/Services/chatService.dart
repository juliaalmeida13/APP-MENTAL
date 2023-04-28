import 'package:http/http.dart' as http;
import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'dart:convert';

import 'api.dart';

final String url = dotenv.env['BACKEND_URL']!;

class ChatService {
  Future<void> sendMessage(String text, String authorId, int idChannel) async {
    var body = jsonEncode(<String, String>{
      'idChannel': idChannel.toString(),
      'isResearcherSender': 'false',
      'text': text,
      'idAuthor': authorId
    });
    final response = await http.post(Uri.parse("${url}sendMessage"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<types.Message>> getChatHistory(
      String email, int idChannel) async {
    final response = await http.get(
        Uri.parse("${url}getChatHistory?email=${email}&idChannel=${idChannel}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (utf8.decode(response.bodyBytes) != "") {
      Iterable iterable = json.decode(utf8.decode(response.bodyBytes));
      return List<types.Message>.from(
          iterable.map((message) => types.Message.fromJson(message)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<int> getIsReadMessages(String userEmail) async {
    final response = await Api().get("getIsReadMessages?email=$userEmail");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<List<String>> getChatNotificationList(String userEmail) async {
    final response =
        await Api().get("getChatNotificationList?email=$userEmail");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
