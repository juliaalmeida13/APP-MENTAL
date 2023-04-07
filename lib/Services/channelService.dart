import 'dart:ffi';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';

import 'dart:convert';

import '../model/channel.dart';

final String url = dotenv.env['BACKEND_URL']!;

class ChannelService {
  Future<List<Channel>> getUserChannels(String email) async {
    final response = await http.get(
        Uri.parse("${url}getUserChannel?email=${email}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (utf8.decode(response.bodyBytes) != "") {
      Iterable iterable = json.decode(utf8.decode(response.bodyBytes));
      return List<Channel>.from(
          iterable.map((message) => Channel.fromJson(message)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
