import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';


class InterventionTitle extends StatelessWidget {
  const InterventionTitle({
    required Key key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-1,0),
      child: Container(
        margin: EdgeInsets.only(top: 40, left: 20),
        child: Text(
          text,
          style:TextStyle(fontFamily: "Inter", color: AppColors.black,
              fontSize: 40,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}