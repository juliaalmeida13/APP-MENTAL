import 'package:app_mental/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);

  AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = FirebaseAuth.instance.currentUser!.displayName ?? "Sem Nome";
    final email = FirebaseAuth.instance.currentUser!.email ?? "Sem Email";
    final image = 'assets/images/woman.png';
    return Drawer(
        child: Container(
      color: AppColors.verdementa,
      child: ListView(
        padding: padding,
        children: <Widget>[
          buildHeader(
              image: image,
              name: name,
              email: email,
              onClicked: () => selectedItem(context, 4)),
          const SizedBox(height: 16),
          buildMenuItem(
            text: 'Home',
            icon: Icons.house,
            onClicked: () => selectedItem(context, 0),
          ),
          const SizedBox(height: 16),
          buildMenuItem(
            text: 'Diário do sono',
            icon: Icons.bed,
            onClicked: () => selectedItem(context, 1),
          ),
          const SizedBox(height: 16),
          buildMenuItem(
            text: 'Questionários',
            icon: Icons.list_alt,
            onClicked: () => selectedItem(context, 2),
          ),
          const SizedBox(height: 16),
          buildMenuItem(
            text: 'Contatos',
            icon: Icons.people,
            onClicked: () => selectedItem(context, 3),
          ),
          const SizedBox(height: 16),
          buildMenuItem(
            text: 'Chat',
            icon: Icons.chat,
            onClicked: () => selectedItem(context, 4),
          )
        ],
      ),
    ));
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      DrawerHeader(
        padding: EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                maxRadius: 30,
                backgroundImage: AssetImage('assets/images/woman.png')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Olá, $name",
                  style: TextStyle(
                      fontFamily: "Inter", fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                      fontFamily: "Inter", fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            InkWell(
              onTap: onClicked,
              child: CircleAvatar(
                backgroundColor: Color(0xFF55A772),
                child: Icon(Icons.chat_bubble, color: Colors.black87),
              ),
            )
          ],
        ),
      );

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.black;
    final hoverColor = AppColors.verdeclaro;

    return ListTile(
        leading: Icon(icon, color: color),
        title: Text(text,
            style: TextStyle(
                fontFamily: "Inter", fontSize: 15, color: Colors.black)),
        hoverColor: hoverColor,
        onTap: onClicked);
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, "/logged-home");
        break;
      case 1:
        Navigator.pushNamed(context, "/sleep-diary");
        break;
      case 2:
        Navigator.pushNamed(context, "/quests-screen");
        break;
      case 3:
        Navigator.pushNamed(context, "/contacts-screen");
        break;
      case 4:
        Navigator.pushNamed(context, "/chat");
        break;
    }
  }
}
