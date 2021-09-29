import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    required Key key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      //It will cover 10% of out total height
      height: size.height * 0.1,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.4,
            decoration: BoxDecoration(
                color: kTextColorGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                )),
          ),
        ],
      ),
    );
  }
}
