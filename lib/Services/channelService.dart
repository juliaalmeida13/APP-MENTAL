import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';

import 'dart:convert';

import '../model/channel.dart';
import 'api.dart';

class ChannelService {
  Future<List<Channel>> getUserChannels(String email) async {
    final response = await Api().get("getUserChannel?email=$email");
    if (json.decode(utf8.decode(response.bodyBytes)) != "") {
      Iterable iterable = json.decode(utf8.decode(response.bodyBytes));
      return List<Channel>.from(
          iterable.map((message) => Channel.fromJson(message)));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
