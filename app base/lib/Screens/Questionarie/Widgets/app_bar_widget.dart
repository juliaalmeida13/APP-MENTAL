import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget()
      : super(
          preferredSize: Size.fromHeight(70),
          child: Stack(children: [
            Center(
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
          ]),
        );
}
