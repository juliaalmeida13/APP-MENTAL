import 'package:app_mental/Screens/Perfil/Widgets/foto_perfil.dart';
import 'package:app_mental/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                  gradient: LinearGradient(
                      begin: Alignment(8e-1, 1),
                      end: Alignment(-1, 8e-1),
                      colors: [
                        Color.fromRGBO(191, 224, 203, 1),
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
                                        text: FirebaseAuth.instance.currentUser!.displayName??"Sem Nome",
                                        style: AppTextStyles.titleBold)
                                  ])),
                            ]),
                      ),
                      Align(alignment: Alignment(0.0, 2.0), child: FotoPerfil())
                    ],
                  ),
                )));
}
