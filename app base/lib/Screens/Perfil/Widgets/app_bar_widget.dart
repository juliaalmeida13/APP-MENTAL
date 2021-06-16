import 'package:chat_app_tutorial/Screens/Perfil/Widgets/foto_perfil.dart';
import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget()
      : super(
            preferredSize: Size.fromHeight(200),
            child: Container(
                width: 375,
                height: 262,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment(8e-1, 1),
                      end: Alignment(-1, 8e-1),
                      colors: [
                        Color.fromRGBO(191, 208, 224, 1),
                        Color.fromRGBO(104, 202, 138, 1)
                      ]),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(70),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(TextSpan(
                                  text: "Olá, ",
                                  style: AppTextStyles.title,
                                  children: [
                                    TextSpan(
                                        text: "Isabella Araujo",
                                        style: AppTextStyles.titleBold)
                                  ])),
                            ]),
                      ),
                      Align(alignment: Alignment(0.0, 2.0), child: FotoPerfil())
                    ],
                  ),
                )));
}
