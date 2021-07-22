import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String completed;
  const QuizCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.completed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
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
                height: MediaQuery.of(context).size.height * .08,
                width: MediaQuery.of(context).size.width * .08,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.cards), fit: BoxFit.fitWidth),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Text(title, style: AppTextStyles.heading15),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(completed, style: AppTextStyles.body11)),
                  /*Expanded(
                    flex: 2,
                    child: LinearProgressIndicator(
                        value: 0.75,
                        backgroundColor: AppColors.verdeclaro,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.verdementa)),
                  )*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
