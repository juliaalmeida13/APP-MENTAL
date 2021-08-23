//Auxiliary Functions with DateTime type
DateTime getNextSunday(DateTime day) {
  var sunday = 7;

  day = day.add(new Duration(days: 1));

  while (day.weekday != sunday) {
    day = day.add(new Duration(days: 1));
  }

  return day;
}

//adding hours instead of weeks for test purpose
DateTime addWeeks({required DateTime day, required int n}) {
  day = day.add(new Duration(hours: 1 * n));
  return day;
}

/*DateTime addWeeks({required DateTime day, required int n}) {
  day = day.add(new Duration(days: 7 * n));
  return day;
}*/
