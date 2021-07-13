import 'package:app_mental/Screens/Reading/Widgets/img_and_text_info.dart';
import 'package:app_mental/Screens/Reading/Widgets/intervention_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Body extends StatelessWidget {
  Body(this.file, this.image);
  final String file;
  final String image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      children: [
        SafeArea(
              child:ImgAndTextInfoCard(key:UniqueKey(), size:size,interventionImage: image, interventionText: file),
          ),
      ],
    );
  }
}

