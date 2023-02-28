import 'package:flutter/material.dart';

import 'Widgets/Body.dart';

class ExportPage extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
