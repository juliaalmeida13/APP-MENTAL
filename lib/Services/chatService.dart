import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'dart:convert';

import 'api.dart';

class ChatService {
  Future<void> sendMessage(String text, String authorId, int idChannel) async {
    var body = jsonEncode(<String, String>{
      'idChannel': idChannel.toString(),
      'isResearcherSender': 'false',
      'text': text,
      'idAuthor': authorId
    });
    final response = await Api().post("sendMessage", body);

    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<types.Message>> getChatHistory(
      String email, int idChannel) async {
    final response =
        await Api().get("getChatHistory?email=$email&idChannel=$idChannel");
    if (utf8.decode(response.bodyBytes) != "") {
      Iterable iterable = json.decode(utf8.decode(response.bodyBytes));
      return List<types.Message>.from(
          iterable.map((message) => types.Message.fromJson(message)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<void> deleteMessage(int id) async {
    final response = await Api().post("deleteMessage", id.toString());
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }
}
