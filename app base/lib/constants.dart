import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

///---COLOR SCHEME---
///Primary Colors & Background
const kPrimaryGreen = Color(0xFFB2FFA9);
const kBackgroundColor = Color(0XFFFFFFFF);
const kBackgroundGrey = Color(0XFFE5E5E5);
const kBackgroundYellow = Color(0XFFFFE66F);

///Secondary Colors
const kSecondaryGreen = Color(0XFF68CA8A);
const kSecondaryBlue = Color(0XFF00AFB9);
const kSecondaryYellow = Color(0XFFFFE150);
const kSecondaryRed = Color(0XFFF6511D);
const kSecondaryGray = Color(0XFFBFD0E0);

///Text Colors
const kTextColorGray = Color(0XFF52635F);
const kTextColorGreen = Color(0xFF68CA8A);

///---STYLE CONSTANTS---
///Padding
const double kDefaultPadding = 20.0;

///Gradients
///
class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFFB2FFA9),
    Color(0xFF68CA8A),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(0.5 * pi));
}

class AppGradients2 {
  static final linear = LinearGradient(colors: [
    Color(0xFF68CA8A),
    Color(0xFFBFD0E0),
  ], stops: [
    0.0,
    1.0
  ], transform: GradientRotation(0.5 * pi));
}

///Text Style
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

  static final TextStyle titulotab =
      TextStyle(fontFamily: "Inter", fontSize: 14, fontWeight: FontWeight.w400);

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

/// app colors
class AppColors {
  //Greens
  static final Color lightGreen = Color(0xFFE1F5EC);
  static final Color green = Color.fromRGBO(104, 202, 138, 1);
  static final Color darkGreen = Color(0xFF04D361);
  static final Color verdeclaro = Color(0xFFB2FFA9);
  static final Color verdementa = Color(0xFF68CA8A);
  static final Color green06 = Color.fromRGBO(104, 202, 138, .6);

  //Blues
  static final Color azulclaro = Color(0xFFBFD0E0);
  static final Color blue = Color(0xFF00AFB9);
  static final Color blue10 = Color(0xFF007EA7);

  //Greys
  static final Color cinza = Color(0xFFE8E8E8);
  static final Color cinzamedio = Color(0xFFF0F0F0);

  //Reds
  static final Color lightRed = Color(0xFFF5E9EC);
  static final Color red = Color(0xFFE5C5CF);
  static final Color darkRed = Color(0xFFCC3750);

  //Yellows
  static final Color amarelo = Color(0xFFFFE66F);
  static final Color laranja = Color(0xFFF6511D);

  //Blacks and Whites
  static final Color black = Color(0xFF000000);
  static final Color white = Color(0xFFFFFFFF);
}

///---IMAGES---
class AppImages {
  static String get appMentalLogo => "assets/images/app_mental_logo.png";
  static String get appMentalLogoText =>
      "assets/images/app_mental_logo_text.png";
  static String get background => "assets/images/background.png";
  static String get searchWhite => "assets/images/background.png";
  static String get send => "assets/images/send.png";
  static String get promis1 => "assets/images/arquivo-medico.png";
}
