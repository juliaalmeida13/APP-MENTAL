import 'package:flutter/material.dart';

class TimeAndText extends StatelessWidget {
  final IconData icon;
  final String time;
  final String text;

  TimeAndText({required this.icon, required this.time, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Container(
                child: Column(
                  children: [
                    Icon(
                      icon,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          time,
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ),
                      FittedBox(child: Text(text)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
