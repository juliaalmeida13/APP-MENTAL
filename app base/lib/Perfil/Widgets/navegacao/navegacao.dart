import 'package:chat_app_tutorial/colors/colors.dart';
import 'package:flutter/material.dart';

class NavegPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black12,
      child: InkWell(
        onTap: () => print('tap on'),
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //IconButton(icon: Icon(Icons.home), onPressed: ),
                Icon(Icons.home),
                Icon(
                  Icons.account_circle,
                ),
                Icon(Icons.assignment_outlined),
                Icon(Icons.group_outlined),
                Icon(Icons.forum_outlined)
              ],
            )),
      ),
    );
  }
}
