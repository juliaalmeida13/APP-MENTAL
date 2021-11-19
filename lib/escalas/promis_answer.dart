import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  // Funcao que será ativada onPressed
  // para mudar adiantar o index do quest/escala e salvar o valor da resposta na lista da escala
  final Function() selectHandler;
  
  //Texto da alternativa
  final String answerText;


// Cria uma botão com o texto de uma resposta passado pelo construtor
// É usado para listar as respostas de uma questão optativa

  AnswerOption(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: selectHandler,
      child: Text(
        this.answerText,
        textAlign: TextAlign.center,
      ),
      style: new ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(12))),
    );
  }
}
