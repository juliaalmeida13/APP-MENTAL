import 'package:flutter/material.dart';

class MainCardButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String page;
  MainCardButton(this.label, this.icon, this.page);

  redirectToPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed(this.page);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        redirectToPage(context);
      },
      child: Card(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(this.icon),
              Text(
                this.label,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
