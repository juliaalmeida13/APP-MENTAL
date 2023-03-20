import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

// Cria um card para representar as escalas/questionários do usuário
class QuizCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String completed;
  final DateTime now;
  final DateTime expirationDate;
  final bool notificationStatus;
  const QuizCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.completed,
      required this.now,
      required this.expirationDate,
      required this.notificationStatus})
      : super(key: key);

  Widget _notification() {
    return notificationStatus
        ? Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    var difference = expirationDate.difference(now);
    var daysToExpire = difference.inDays;
    var hoursToExpire = difference.inHours;
    var minutesToExpire = difference.inMinutes;

    String expirationText;

    // Calcula a constroi o texto para informar o usuário do período restante em que a escala/questionário estará disponível
    if (daysToExpire > 0) {
      expirationText = 'Expira em $daysToExpire dia(s)';
    } else if (hoursToExpire > 0) {
      expirationText = 'Expira em $hoursToExpire hora(s)';
    } else {
      expirationText = 'Expira em $minutesToExpire minuto(s)';
    }

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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _notification(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .08,
                    width: MediaQuery.of(context).size.width * .08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.cards),
                          fit: BoxFit.fitWidth),
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
                          child: FittedBox(
                            child: Text(
                              completed,
                              style: AppTextStyles.body11,
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Text(
                            expirationText,
                            textAlign: TextAlign.right,
                            style: AppTextStyles.body11,
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
