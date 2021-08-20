import 'package:app_mental/Screens/ChatRoom/chatRoomsScreen.dart';
import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Screens/Home/home_screen.dart';
import 'package:app_mental/Screens/Perfil/perfil.dart';
import 'package:app_mental/Screens/Questionarie/quests_screen.dart';
import 'package:app_mental/Screens/SleepDiary/diario_sono.dart';
import 'package:app_mental/Screens/SleepDiary/sleep_diary.dart';
import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  AuthMethods authMethods = new AuthMethods();

  List<Widget> _screens = [
    HomeScreen(),
    SleepPage(),
    ProfilePage(),
    ContactsScreen(),
    QuestsScreen(),
  ];

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextColorGreen,
        shadowColor: Color.fromRGBO(1, 1, 1, 0),
        actions: [
        GestureDetector(
          onTap: () {
            authMethods.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, "/sign-in", (Route<dynamic> route) => false);
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app)),
        ),
      ],),
      drawer: AppDrawer(),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: index == _selectedIndex ? Colors.blue : Colors.grey,
      ),
      label: '',
    );
  }
}
