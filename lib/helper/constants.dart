class Constants {
  static String myName = "";
  static String myEmail = "";
  static String uid = "";
  static int criticalValueAssistN2 = 11;
  static int recommendationValueAssistN2 = 3;
  static int criticalValueMdq = 6;
  static int criticalValuePhq15 = 9;
  static int criticalValueGad7 = 10;
  static int criticalValuePhq9 = 5;
  static int criticalValuePsqi = 10;
  static int recommendationValuePsqi = 4;
  static List<String> civil = [
    "Solteiro",
    "Casado",
    "União Estável",
    "Divorciado",
    "Viúvo"
  ];
  static List<String> gender = [
    "Feminino",
    "Masculino",
    "Neutro",
    "Fluido" "Outro"
  ];
}

enum QuestionnaireCode {
  ccsm,
  phq9,
  pset,
  pcl5,
  questSD1,
  questSD2,
  mdq,
  gad7,
  phq15,
  psqi,
  assist,
  assistn2,
  sleepQuestionnaire,
  copsoq,
  quesi
}
