import 'package:flutter/material.dart';
// import './categories_screen.dart';

class Result extends StatelessWidget {
  final List<int> resultScoreList;
  final int resultScore;
  //final Function resetHandler;

  Result({this.resultScoreList, this.resultScore});

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesScreen.routeName,
    );
  }*/

  final String resultPhrase =
      'Questionário concluído! \n\nLogo informaremos as próximas atividades.';

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
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        /*FlatButton(
          child: Text('Retornar ao menu'),
          textColor: Colors.blue,
          onPressed: () => {
            Navigator.of(context).pushNamed(
              CategoriesScreen.routeName,
              arguments: {},
            )
          },
        ),*/
      ],
    );
  }
}
