import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  //final Function resetHandler;

  Result(this.resultScore);

  String get resultPhrase {
    var resultText;
    if (resultScore >= 10) {
      resultText = 'Entre em contato com um de nossos pesquisadores!';
      print(resultScore);
    } else {
      resultText =
          'Questionário concluído! \n\nLogo informaremos as próximas atividades.';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          resultPhrase,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          child: Text('Retornar ao menu'),
          textColor: Colors.blue,
          onPressed: () => {Navigator.pop(context)},
        ),
      ],
    );
  }
}
