import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  //final User user;

  //const Info(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 75, left: 25, right: 25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4)
                  ],
                  color: Color.fromRGBO(246, 246, 246, 1),
                ),
              )),

          //parte inicial da tela de perfil, ou seja, 'perfil' e botão para editar as informações do paciente
          Padding(
            padding: const EdgeInsets.only(top: 85, left: 35, right: 35),
            child: Row(
              children: [
                Text("Perfil: ",
                    textAlign: TextAlign.left, style: AppTextStyles.perfil),
              ],
            ),
          ),

          //box do e-mail do paciente
          Padding(
            padding: const EdgeInsets.only(top: 115, left: 35, right: 35),
            child: Container(
              width: 335,
              height: 38,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: AppColors.cinza),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 122, left: 45, right: 35),
            child: Text(
              'E-mail: ',
              style: AppTextStyles.perfil,
            ),
          ),

          //box da idade
          Padding(
            padding: const EdgeInsets.only(top: 170, left: 35, right: 35),
            child: Container(
              width: 150,
              height: 38,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: AppColors.cinza),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 177, left: 45, right: 35),
            child: Text(
              'Idade: ',
              style: AppTextStyles.perfil,
            ),
          ),

          //box da profissão
          Padding(
            padding: const EdgeInsets.only(top: 225, left: 35, right: 35),
            child: Container(
              width: 335,
              height: 38,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: AppColors.cinza),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 232, left: 45, right: 35),
            child: Text(
              'Profissão: ',
              style: AppTextStyles.perfil,
            ),
          ),

          //gênero
          Padding(
            padding: const EdgeInsets.only(top: 280, left: 43, right: 35),
            child: Text(
              'Gênero: ',
              style: AppTextStyles.perfil,
            ),
          ),

          //feminino
          Padding(
            padding: const EdgeInsets.only(top: 314, left: 43, right: 35),
            child: Row(
              children: [
                Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(196, 196, 196, 1),
                      borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                    )),
                Text('  Feminino', style: AppTextStyles.perfil),
                Padding(
                  padding: const EdgeInsets.only(left: 63),
                  child: Row(
                    children: [
                      Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(196, 196, 196, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(15, 15)),
                          )),
                      Text("  Masculino", style: AppTextStyles.perfil)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 348, left: 43, right: 35),
            child: Row(
              children: [
                Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(196, 196, 196, 1),
                      borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                    )),
                Text("  Não-binário", style: AppTextStyles.perfil)
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
