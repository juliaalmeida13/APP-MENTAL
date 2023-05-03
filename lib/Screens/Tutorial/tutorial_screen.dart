import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  _goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/logged-home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.green,
          shadowColor: Colors.transparent,
          title: Text("Tutorial"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _goBackPage(context),
          ),
        ),
        body: Flex(direction: Axis.vertical, children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Nas próximas 16 semanas, você participará da pesquisa \“Desenvolvimento de intervenções de promoção, "
                  "prevenção, rastreio e cuidado em saúde mental para profissionais da Atenção Primária à Saúde "
                  "que atuam no combate do novo coronavírus por meio de  um sistema computacional adaptativo "
                  "de saúde digital\"\n\n"
                  "Nas 12 primeiras semanas, você fará uso do aplicativo: APP Mental (Avaliação, Promoção e "
                  "Prevenção em Saúde Mental). * nas últimas 4 semanas, você não mais estará usando o "
                  "aplicativo; você será convidado a participar de dois encontros (virtuais) com os "
                  "pesquisadores para falar de sua experiência.\n\n"
                  "Durante o uso do APP Mental, semanalmente, você responderá a questionários de avaliação da "
                  "saúde mental. A ideia é que seja algo que contribua para sua saúde. Faça no seu ritmo! "
                  "Em alguns momentos, você poderá não estar disposto a responder; não tem problema! Você "
                  "pode interromper e retomar o questionário quando quiser. As informações sobre sua saúde "
                  "mental e sua opinião sobre esse processo de responder a esses questionários são muito "
                  "importantes!\n\n Além desses questionários, você terá à sua disponibilidade um banco de "
                  "intervenções de promoção e prevenção em saúde. Você pode acessá-lo quando quiser.Nossa "
                  "sugestão é acessar uma das intervenções de 2 a 3 vezes por semana. Não se esqueça que "
                  "o nosso intuito é de que seja algo que contribua com sua qualidade de vida, por isso, "
                  "faça na frequência que julgar possível dentro de sua rotina.\n\n "
                  "No período da pesquisa, podem surgir momentos em que você precise de alguma orientação "
                  "ou acolhimento, teremos uma equipe de três pesquisadores para o acolhimento das "
                  "necessidades de saúde mental, a Profa. Larissa Martini, terapeuta ocupacional, o "
                  "psiquiatra e prof. Jair Barbosa e a mestranda Karina Toledo, que também é psiquiatra. "
                  "Você pode nos contactar pelo chat, disponível no APP Mental, todos os três pesquisadores "
                  "terão acesso às mensagens enviadas por lá, os outros participantes (sujeitos) da pesquisa "
                  "não terão acesso às mensagens, se você preferir não ser identificada(o) pelo chat, por "
                  "favor, mantenha o seu codinome ou então nos contate  pelo email.\n\n"
                  "Seja bem-vindo(a) ao APP Mental!",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
