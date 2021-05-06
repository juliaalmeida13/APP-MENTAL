import 'dart:ui';
import 'package:flutter/material.dart';
import 'colors.dart';

//Estilos de texto utilizando a fonte INTER

class AppTextStyles {
  static final TextStyle contatos = TextStyle(
      fontFamily: "Inter",
      color: AppColors.black,
      fontSize: 35,
      fontWeight: FontWeight.w600,
      height: 3);

  static final TextStyle tituloatividades = TextStyle(
      fontFamily: "Inter",
      color: AppColors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600);

  static final TextStyle descratividades = TextStyle(
      fontFamily: "Inter",
      color: AppColors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static final TextStyle contatosbody = TextStyle(
      fontFamily: "Inter",
      color: Color.fromRGBO(92, 86, 86, 1),
      fontSize: 16,
      fontWeight: FontWeight.w600);

  static final TextStyle title = TextStyle(
    fontFamily: "Inter",
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle perfil = TextStyle(
    fontFamily: "Inter",
    color: Color.fromRGBO(125, 125, 125, 1),
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle titleBold = TextStyle(
      fontFamily: "Inter",
      color: AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1);

  static final TextStyle atividade = TextStyle(
    fontFamily: "Inter",
    color: AppColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle heading = TextStyle(
    fontFamily: "Inter",
    color: AppColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle heading40 = TextStyle(
    fontFamily: "Inter",
    color: AppColors.black,
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle heading15 = TextStyle(
    fontFamily: "Inter",
    color: AppColors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body = TextStyle(
    fontFamily: "Inter",
    color: AppColors.cinzamedio,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyBold = TextStyle(
    fontFamily: "Inter",
    color: AppColors.cinzamedio,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bodylightgrey = TextStyle(
    fontFamily: "Inter",
    color: AppColors.lightGreen,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle bodyDarkGreen = TextStyle(
    fontFamily: "Inter",
    color: AppColors.darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bodyDarkRed = TextStyle(
    fontFamily: "Inter",
    color: AppColors.darkRed,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle body20 = TextStyle(
    fontFamily: "Inter",
    color: AppColors.cinzamedio,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyWhite14 = TextStyle(
    fontFamily: "Inter",
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyWhite16 = TextStyle(
    fontFamily: "Inter",
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle body11 = TextStyle(
    fontFamily: "Inter",
    color: Colors.black45,
    fontSize: 11,
    fontWeight: FontWeight.normal,
  );
}
