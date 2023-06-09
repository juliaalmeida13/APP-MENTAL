class Constants {
  static String myName = "";
  static String myEmail = "";
  static String uid = "";
  static int criticalValueAssistN2 = 11;
  static int recommendationValueAssistN2 = 3;
  static int criticalValueMdq = 6;
  static int criticalValuePhq15 = 9;
  static int criticalValuePromisAnsi = 19;
  static int criticalValuePromisN2 = 16;
  static int criticalValuePsqi = 10;
  static int recommendationValuePsqi = 4;
  static List<String> civil = [
    "Solteiro(a)",
    "Casado(a)",
    "União Estável",
    "Viúvo(a)"
  ];
  static List<String> gender = ["Feminino", "Masculino", "Outro"];
}

enum QuestionnaireCode {
  pn1,
  pn2,
  pset,
  pcl5,
  questSD1,
  questSD2,
  mdq,
  pn2A,
  phq15,
  psqi,
  assist,
  assistn2,
  sleepQuestionnaire
}
