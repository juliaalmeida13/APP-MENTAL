import 'package:app_mental/model/reading.dart';
import 'package:app_mental/model/exceptions/HttpException.dart';
import 'package:app_mental/model/exceptions/apiError.dart';

import 'dart:convert';

import '../model/reading_rating.dart';
import '../model/reading_rel_user_dto.dart';
import 'api.dart';

class ReadingService {
  Future<void> addNewReadingRating(
      String email, int readingId, double rating, String comment) async {
    final response = await Api().post(
        "rateReading",
        jsonEncode(<String, dynamic>{
          'email': email,
          'readingId': readingId,
          'rating': rating,
          'comment': comment
        }));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<ReadingRating> findReadingRating(String email, int readingId) async {
    final response = await Api()
        .get("searchReadingRating?email=$email&readingId=$readingId");
    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) != "") {
        return ReadingRating.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        return ReadingRating();
      }
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<int> getReadingIsReadCount(String email) async {
    final response = await Api().get("getReadingIsReadCount?email=$email");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<int> getReadingVersion() async {
    final response = await Api().get("getReadingVersion");
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<void> readingIsRead(String email, String name, String group) async {
    final response = await Api().post(
        "readingIsRead",
        jsonEncode(
            <String, dynamic>{'email': email, 'name': name, 'group': group}));
    if (response.statusCode != 200) {
      final error =
          ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      throw HttpException(error.message.toString());
    }
  }

  Future<List<Reading>> getReadings() async {
    final response = await Api().get("getReadings");
    List<Reading> readingList = [];
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      for (var reading in jsonList) {
        readingList.add(Reading.fromJson(reading));
      }
      return readingList;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }

  Future<List<ReadingRelUserDTO>> getReadingNotificationList(
      String email) async {
    final response = await Api().get("getReadingNotificationList?email=$email");
    List<ReadingRelUserDTO> readingRelUserDTOList = [];
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      for (var readingRelUserDTO in jsonList) {
        readingRelUserDTOList
            .add(ReadingRelUserDTO.fromJson(readingRelUserDTO));
      }
      return readingRelUserDTOList;
    }
    final error =
        ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    throw HttpException(error.message.toString());
  }
}
