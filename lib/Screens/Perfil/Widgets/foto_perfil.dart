import 'package:flutter/material.dart';

class FotoPerfil extends StatelessWidget {
  //const FotoPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(100, 100, 100, 0.15000000596046448),
                offset: Offset(0, 4),
                blurRadius: 20)
          ],
          border: Border.all(
            color: Color.fromRGBO(255, 255, 255, 1),
            width: 4,
          ),
          image: DecorationImage(
              image: AssetImage('assets/images/woman.png'),
              fit: BoxFit.fitWidth),
          borderRadius: BorderRadius.all(Radius.elliptical(158, 158)),
        ));
  }
}
