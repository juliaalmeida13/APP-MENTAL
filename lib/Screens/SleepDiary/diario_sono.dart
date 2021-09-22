import 'package:flutter/material.dart' hide TimePickerDialog;
import 'package:survey_kit/survey_kit.dart';
import 'package:intl/intl.dart';

class DiarioSono extends StatefulWidget {
  @override
  _DiarioSonoState createState() => _DiarioSonoState();
}

class _DiarioSonoState extends State<DiarioSono> {
  late DateTime pickedDate;
  late String data;
  String _resQuest1 = "00:00";
  String _resQuest2 = "00:00";
  String _resQuest3 = "00:00";
  int qtd = 0;
  String _resQuest5 = "00:00";
  String _resQuest6 = "00:00";
  String _resQuest7 = "00:00";
  String _resQuest8 = "00:00";

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    data = DateFormat("dd-MM-yyyy").format(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: double.infinity,
            width: 600,
            child: SurveyKit(
              surveyController:
              SurveyController(onCloseSurvey: (context, resultFunction) {
                print('cancelado');
              }),
              onResult: (SurveyResult result) async {
                print('enviado');

                _resQuest1 = DateFormat("HH:mm").format(DateFormat.jm().parse(
                    result.results[1].results.first.result.format(context)));
                _resQuest2 = DateFormat("HH:mm").format(DateFormat.jm().parse(
                    result.results[2].results.first.result.format(context)));
                _resQuest3 = DateFormat("HH:mm").format(DateFormat.jm().parse(
                    result.results[3].results.first.result.format(context)));
                qtd = result.results[4].results.first.result;
                _resQuest5 = DateFormat("HH:mm").format(DateFormat.jm().parse(
                    result.results[5].results.first.result.format(context)));
                _resQuest6 = DateFormat("HH:mm").format(DateFormat.jm().parse(
                    result.results[6].results.first.result.format(context)));
                _resQuest7 = DateFormat("HH:mm").format(DateFormat.jm().parse(
                    result.results[7].results.first.result.format(context)));
                _resQuest8 = DateFormat("HH:mm").format(DateFormat.jm().parse(
                    result.results[8].results.first.result.format(context)));

                print(_resQuest1);
                print(_resQuest2);
                print(_resQuest3);
                print(qtd.toString());
                print(_resQuest5);
                print(_resQuest6);
                print(_resQuest7);
                print(_resQuest8);

                /*await showInformationDialog(
                    context,
                    calculoEficienciaSono(_resQuest1, _resQuest2, _resQuest3,
                        qtd, _resQuest5, _resQuest6, _resQuest7, _resQuest8),
                    pickedDate);*/
              },
              task: getSampleTask(),
              themeData: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.cyan,
                ).copyWith(
                  onPrimary: Colors.white,
                ),
                primaryColor: Colors.cyan,
                backgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(
                    color: Colors.cyan,
                  ),
                  textTheme: TextTheme(
                    button: TextStyle(
                      color: Colors.cyan,
                    ),
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.cyan,
                ),
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(150.0, 60.0),
                    ),
                    side: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                        if (state.contains(MaterialState.disabled)) {
                          return BorderSide(
                            color: Colors.grey,
                          );
                        }
                        return BorderSide(
                          color: Colors.cyan,
                        );
                      },
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    textStyle: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                        if (state.contains(MaterialState.disabled)) {
                          return Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.grey,
                          );
                        }
                        return Theme.of(context).textTheme.button?.copyWith(
                          color: Colors.cyan,
                        );
                      },
                    ),
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.button?.copyWith(
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Task getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Bem vindo ao\nQuestionário do sono\n',
          text: 'Por favor, é importante que os horários sejam sinceros',
          buttonText: 'Vamos lá!',
        ),
        QuestionStep(
          title: 'Que horas você foi para a cama?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 14,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title: 'A que horas você tentou dormir?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 13,
              minute: 30,
            ),
          ),
        ),
        QuestionStep(
          title: 'Quanto tempo você demorou para adormecer?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 0,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title:
          'Quantas vezes você acordou, sem contar o seu despertar final?',
          answerFormat: IntegerAnswerFormat(
              defaultValue: 0, hint: 'Por favor insira a quantidade'),
        ),
        QuestionStep(
          title: 'No total, quanto tempo durou esse despertar?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 0,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title: 'A que horas foi seu despertar final?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 0,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title: 'Após seu despertar final, quanto tempo você passou na cama?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 0,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title: 'Quanto você dormiu durante o dia?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 0,
              minute: 0,
            ),
          ),
        ),
        CompletionStep(
            //id: StepIdentifier(id: '321'),
            text:
                'Obrigado por responder o questionário!\n Por favor, volte amanha!',
            title: 'Pronto!',
            buttonText: 'Enviar respostas',
            stepIdentifier: StepIdentifier()),
      ],
    );
    return task;
  }
}

Future<void> showInformationDialog(
    BuildContext context, List<String> text, DateTime pickedDate) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 2.3,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 13,
                  alignment: Alignment.center,
                  child: Text(
                    "Tempo total de sono \n ${text[0]}",
                    textAlign: TextAlign.center,
                  ),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 13,
                  alignment: Alignment.center,
                  child: Text(
                    "Tempo total na cama\n ${text[1]}",
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 13,
                  alignment: Alignment.center,
                  child: Text(
                    "Eficiência do sono\n ${text[2]}%",
                    textAlign: TextAlign.center,
                  ),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
                ),
              ],
            )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ok'),
          )
        ],
      );
    },
  );
}

calculoEficienciaSono(
    String _resQuest1,
    String _resQuest2,
    String _resQuest3,
    int qtd,
    String _resQuest5,
    String _resQuest6,
    String _resQuest7,
    String _resQuest8) {
  //<<<<<<<<<< pega quanto tempo a pessoa dormiu >>>>>>>>>>
  var format = DateFormat("HH:mm");
  var quest1 = format.parse(_resQuest1).subtract(Duration(hours: 12));
  var quest2 = format.parse(_resQuest2).subtract(Duration(hours: 12));
  var quest3 = format.parse(_resQuest3);
  var quest5 = format.parse(_resQuest5);
  var quest6 = format.parse(_resQuest6).add(Duration(hours: 12));
  var quest7 = format.parse(_resQuest7);

  var intervaloTentouDormirEAcordou =
  format.parse(quest6.difference(quest2).toString());

  var intervaloFoiParaCamaEAcordou =
  format.parse(quest6.difference(quest1).toString());

  var demorouDomirMaisTotalDespertar =
  quest3.add(Duration(hours: quest5.hour, minutes: quest5.minute));
  var tempoTotalDeSono = intervaloTentouDormirEAcordou.subtract(Duration(
    hours: demorouDomirMaisTotalDespertar.hour,
    minutes: demorouDomirMaisTotalDespertar.minute,
  ));

  var tempoTotalNaCama = intervaloFoiParaCamaEAcordou.add(Duration(
    hours: quest7.hour,
    minutes: quest7.minute,
  ));

  String tts = DateFormat("HH:mm").format(tempoTotalDeSono);
  String ttc = DateFormat("HH:mm").format(tempoTotalNaCama);

  var ttsString = tts.split(":");
  var ttcString = ttc.split(":");
  int ttsInt = int.parse(ttsString[0]) * 60 + int.parse(ttsString[1]);
  int ttcInt = int.parse(ttcString[0]) * 60 + int.parse(ttcString[1]);

  double res = ((ttsInt / ttcInt) * 100).truncateToDouble();

  List<String> res2 = [
    tts,
    ttc,
    res.toString(),
  ];

  print(tts);
  print(ttc);
  print(res.toString());

  return res2;
}
