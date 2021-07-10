import 'package:chat_app_tutorial/Screens/Contacts/contacts_screen.dart';
import 'package:chat_app_tutorial/Screens/Home/home_screen.dart';
import 'package:chat_app_tutorial/Screens/Perfil/perfil.dart';
import 'package:chat_app_tutorial/Screens/Questionarie/quests_screen.dart';
import 'package:chat_app_tutorial/Screens/SleepDiary/sleep_diary.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
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
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar:
          /*BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          buildBottomNavigationBarItem(Icons.home, 0),
          buildBottomNavigationBarItem(
              Icons.airline_seat_individual_suite_sharp, 1),
          buildBottomNavigationBarItem(Icons.account_circle_rounded, 2),
          buildBottomNavigationBarItem(Icons.quick_contacts_mail_rounded, 3),
          buildBottomNavigationBarItem(Icons.dynamic_form_outlined, 4)
        ],
      ),*/
          CurvedNavigationBar(
        height: 50,
        onTap: _onItemTapped,
        color: kTextColorGreen,
        backgroundColor: AppColors.white,
        buttonBackgroundColor: AppColors.verdeclaro,
        items: <Widget>[
          Icon(Icons.home, size: 20, color: Colors.black87),
          Icon(Icons.airline_seat_individual_suite_sharp,
              size: 20, color: Colors.black87),
          Icon(Icons.account_circle_rounded, size: 20, color: Colors.black87),
          Icon(Icons.quick_contacts_mail_rounded,
              size: 20, color: Colors.black87),
          Icon(Icons.article_outlined, size: 20, color: Colors.black87)
        ],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.linear,
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
