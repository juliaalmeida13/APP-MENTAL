import 'package:app_mental/Services/auth.dart';
import 'package:flutter/material.dart';

import 'Widgets/Body.dart';

class ExportPage extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  AuthMethods authMethods = new AuthMethods();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
