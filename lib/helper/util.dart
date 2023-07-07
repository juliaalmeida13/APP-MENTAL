import 'dart:ui';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}

String getUserName(types.User user) => '${user.firstName ?? ''}'.trim();

String? validateEntry(value) {
  if (value!.isEmpty) {
    return 'vazio';
  }
  return null;
}

bool isCheckboxQuestion(String questionnaireCode, int questionIndex) {
  return ((questionnaireCode == "copsoq" &&
          (questionIndex == 38 ||
              questionIndex == 40 ||
              questionIndex == 42 ||
              questionIndex == 44)) ||
      (questionnaireCode == "questSD1" && questionIndex == 14) ||
      (questionnaireCode == "questSD2" &&
          (questionIndex == 9 || questionIndex == 10)));
}
