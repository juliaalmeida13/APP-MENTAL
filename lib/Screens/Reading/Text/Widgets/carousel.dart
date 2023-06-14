import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatelessWidget {
  final List<String> carouselImages;

  Carousel({required this.carouselImages});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true, height: MediaQuery.of(context).size.height * 0.3),
      items: carouselImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(204, 204, 204, 1)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.memory(
                base64Decode(i),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
