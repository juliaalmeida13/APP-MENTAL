import 'package:app_mental/escalas/success_dialog.dart';
import 'package:flutter/material.dart';

class QuestSD2Result extends StatelessWidget {
  final String resultPhrase =
      'Segunda e última parte do Questionário Sociodemográfico concluída! \n\nSuas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\n\nEstá de acordo?';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          resultPhrase,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * .03,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(104, 202, 138, 1)),
            child: const Text('Sim, estou de acordo',
                style: TextStyle(color: Colors.black)),
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => SuccessDialog());
            },
          ),
        ),
      ],
    );
  }
}
