import 'package:chat_app_tutorial/colors/app_text_styles.dart';
import 'package:chat_app_tutorial/colors/colors.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget()
      : super(
          preferredSize: Size.fromHeight(195),
          child: Stack(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Suas atividades",
                      style: AppTextStyles.atividade,
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    width: 115,
                    height: 52,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: AppColors.verdementa),
                    child: Center(
                        child: Text(
                      "Nesta semana",
                      style: AppTextStyles.bodyWhite14,
                    ))),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 135),
              child: Container(
                width: 531,
                height: 60,
                decoration: BoxDecoration(color: AppColors.verdementa),
                child: Center(
                    child: Text(
                  "Cheque aqui atividades disponíveis para essa semana",
                  style: AppTextStyles.bodyWhite16,
                )),
              ),
            ))
          ]),
        );
}
