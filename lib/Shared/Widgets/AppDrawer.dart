import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:package_info_plus/package_info_plus.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  String version = "";
  String userName = "a";
  String userEmail = "a";

  @override
  initState() {
    getVersion().then((String data) {
      setState(() {
        version = data;
      });
    });
    getUserNameAndEmail();
    super.initState();
  }

  getUserNameAndEmail() async {
    await HelperFunctions.getUserNameAndEmailInSharedPreference().then((user) {
      setState(() {
        userName = user["name"];
        userEmail = user["email"];
      });
    });
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    final displayName = userName;
    final displayEmail = userEmail;
    final image = 'assets/images/woman.png';
    final user = types.User(
        id: "",
        role: types.Role
            .user); //arrumar a classe usuário e ifs abaixo talvez sejam desnecessários
    return Drawer(
      backgroundColor: AppColors.verdementa,
      child: ListView(
        children: <Widget>[
          buildHeader(
              image: image,
              name: truncateWithEllipsis(10, displayName),
              email: displayEmail,
              onClicked: () => selectedItem(context, 4)),
          if (user.role == types.Role.user) ...[
            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Home',
              icon: Icons.house,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Diário do sono',
              icon: Icons.bed,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Leituras',
              icon: Icons.book_online,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Questionários',
              icon: Icons.list_alt,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Contatos',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 4),
            )
          ] else if (user.role == types.Role.agent) ...[
            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Chat',
              icon: Icons.list_alt,
              onClicked: () => selectedItem(context, 5),
            ),
          ],
          const SizedBox(height: 8),
          buildMenuItem(
            text: 'Tutorial',
            icon: Icons.book,
            onClicked: () => selectedItem(context, 6),
          ),
          const SizedBox(height: 8),
          buildMenuItem(
            text: 'Sair',
            icon: Icons.exit_to_app,
            onClicked: () {
              AuthMethods().signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/sign-in", (Route<dynamic> route) => false);
            },
          ),
          if (user.role == types.Role.user) ...[
            Container(
              //pode ser que seja o tamanho desse container
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.chat_rounded),
                      title: Text('Falar com pesquisador'),
                      onTap: () => openChat(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
          // AsyncSnapshot<Your object type>
          if (version != "") ...[
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 10),
              alignment: AlignmentDirectional.topStart,
              child: Text(
                "Versão: " + version,
                style: TextStyle(
                    fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.3)),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      DrawerHeader(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
                maxRadius: 30,
                backgroundImage: AssetImage('assets/images/profile-user.png')),
            const SizedBox(
              height: 10,
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .47,
                  child: FittedBox(
                    child: Text(
                      "Olá, $name",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontFamily: "Inter", color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: MediaQuery.of(context).size.width * .47,
                  child: FittedBox(
                    child: Text(
                      email,
                      style:
                          TextStyle(fontFamily: "Inter", color: Colors.black),
                    ),
                  ),
                ),
              ],
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

  void openChat(BuildContext context) async {
    /*var user = await DatabaseMethods()
        .getFirstContact()
        .catchError((error, stackTrace) {
      print(error);
    });
    var room = await FirebaseChatCore.instance.createRoom(user);
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );*/
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return Future.value(version + "-" + buildNumber);
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/logged-home");
        break;
      case 1:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/sleep-diary");
        break;
      case 2:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/readings");
        break;
      case 3:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/quests-screen");
        break;
      case 4:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/contacts-screen");
        break;
      case 5:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/users");
        break;
      case 6:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/tutorial");
        break;
    }
  }
}
