import 'package:flutter/cupertino.dart';
import 'package:chat_app_tutorial/colors/app_text_styles.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget()
      : super(
            preferredSize: Size.fromHeight(100),
            child: Container(
                child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    " Chat com pesquisador",
                    style: AppTextStyles.contatos,
                  )
                ],
              ),
            )));
}
