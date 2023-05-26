class Sleep {
  final String gotoBed;
  final String tryToSleep;
  final String whileToSleep;
  final int? timesWokeUp;
  final String? timeAwake;
  final String wakeUpTime;
  final String spendInBed;
  final String sleepDuringDay;
  final String totalTimeSleep;
  final String sleepEfficiency;

  const Sleep(
      {required this.gotoBed,
      required this.tryToSleep,
      required this.whileToSleep,
      required this.timesWokeUp,
      required this.timeAwake,
      required this.wakeUpTime,
      required this.spendInBed,
      required this.sleepDuringDay,
      required this.totalTimeSleep,
      required this.sleepEfficiency});

  factory Sleep.fromJson(Map<String, dynamic> json) {
    return Sleep(
      gotoBed: json['gotoBed'],
      tryToSleep: json['tryToSleep'],
      whileToSleep: json['whileToSleep'],
      timesWokeUp: json['timesWokeUp'],
      timeAwake: json['timeAwake'],
      wakeUpTime: json['wakeUpTime'],
      spendInBed: json['spendInBed'],
      sleepDuringDay: json['sleepDuringDay'],
      totalTimeSleep: json['totalTimeSleep'],
      sleepEfficiency: json['sleepEfficiency'],
    );
  }
}
