import 'package:flutter/material.dart';

class MainCardButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String page;
  final int notification;

  MainCardButton(this.label, this.icon, this.page, this.notification);

  redirectToPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed(this.page);
  }

  Widget _notification() {
    return notification != 0
        ? Container(
            width: 20,
            height: 20,
            decoration: new BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: FittedBox(child: Text(notification.toString())),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        redirectToPage(context);
      },
      child: Card(
        child: Container(
          width: 150,
          height: 150,
          child: Stack(
            children: [
              Container(
                width: 150,
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
              Container(
                width: 150,
                height: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _notification(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
