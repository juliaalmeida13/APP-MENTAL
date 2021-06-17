import 'package:chat_app_tutorial/constants.dart';
import 'package:chat_app_tutorial/escalas/promisn1/promisn1_screen.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Promisn1Screen.routeName,
              arguments: {'title': 'PROMIS Nível 1'});
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.fromBorderSide(BorderSide(color: Colors.black12)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, offset: Offset(0, 2), blurRadius: 4)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    /*image: DecorationImage(
                      image: AssetImage(AppImages.promis1),
                      fit: BoxFit.fitWidth),*/
                    ),
              ),
              SizedBox(
                height: 24,
              ),
              Text("PROMIS Nível 1", style: AppTextStyles.heading15),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text("3 de 5", style: AppTextStyles.body11)),
                  Expanded(
                    flex: 2,
                    child: LinearProgressIndicator(
                        value: 0.75,
                        backgroundColor: AppColors.verdeclaro,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.verdementa)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
