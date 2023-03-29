import 'package:intl/intl.dart';

String getDateNow() {
  var todayDate = DateTime.now();
  var formatterDate = DateFormat('dd-MM-yy HH-mm');
  String formattedDate = formatterDate.format(todayDate);
  return formattedDate;
}

String getFormattedDayAndHourFrom(String date) {
  return date.replaceAll("-", "/") + "h";
}

String getFormattedDayAndHour(String path) {
  String string = path.substring(path.length - 18);
  String str = string.substring(0, string.length - 4);
  String string1 = str.replaceAll("-", "/");
  return string1.substring(0, 11) + ":" + string1.substring(12) + "h";
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
}
