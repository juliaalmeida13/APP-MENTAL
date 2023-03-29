import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.image,
    required this.size,
  });

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: size.width * 0.9,
      height: 200,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              width: size.width,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                  image: AssetImage(image),
                  width: size.width,
                  height: 250,
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
