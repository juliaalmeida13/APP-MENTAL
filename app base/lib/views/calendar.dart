//Auxiliary Functions with DateTime type
DateTime getNextSunday(DateTime day) {
  var sunday = 7;

  while (day.weekday != sunday) {
    day = day.add(new Duration(days: 1));
  }

  return day;
}

DateTime addWeeks({DateTime day, int n}) {
  day = day.add(new Duration(days: 7 * n));
  return day;
}
