import 'dart:io';

import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Services/userService.dart';

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
  String imageFile = "loading";

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
      getAvatarImageFromDatabase(user["email"]);
    });
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  pickNewAvatarImage() async {
    setState(() {
      imageFile = "loading";
    });
    final status = await Permission.storage.status;
    String folderPath = "";
    if (status != PermissionStatus.granted) {
      await Permission.storage.request();
    }
    if (await Permission.storage.status.isGranted) {
      Directory folderDir = await getApplicationDocumentsDirectory();
      folderPath = folderDir.path;
    }
    final picker = ImagePicker();
    final pickedImagem = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImagem != null) {
      File pickedImageFile = File(pickedImagem.path);
      Reference referenceImageToUpload =
          FirebaseStorage.instance.ref().child('$userEmail/profile-avatar');
      try {
        await referenceImageToUpload.putFile(File(pickedImageFile.path));
        await referenceImageToUpload.getDownloadURL().then((imageUrl) {
          UserService().saveUserAvatar(userEmail, imageUrl);
          saveImageInApp(folderPath, pickedImageFile);
        });
      } catch (error) {
        print(error);
      }
    }
  }

  deleteImageFile(String filePath) {
    if (File(filePath).existsSync()) {
      File(filePath).delete();
    }
  }

  saveImageInApp(String folderPath, File pickedImageFile) async {
    if (File("$folderPath/$userEmail/profile-avatar.png").existsSync()) {
      await pickedImageFile.copy("$folderPath/$userEmail/profile-avatar1.png");
      setState(() {
        imageFile = "$folderPath/$userEmail/profile-avatar1.png";
      });
      deleteImageFile("$folderPath/$userEmail/profile-avatar.png");
    } else {
      if (!await Directory("$folderPath/$userEmail").exists()) {
        await Directory("$folderPath/$userEmail").create();
      }
      await pickedImageFile.copy("$folderPath/$userEmail/profile-avatar.png");
      setState(() {
        imageFile = "$folderPath/$userEmail/profile-avatar.png";
      });
      deleteImageFile("$folderPath/$userEmail/profile-avatar1.png");
    }
  }

  getAvatarImageFromDatabase(String userEmail) async {
    await UserService().getUserAvatar(userEmail).then((avatarUrl) {
      if (avatarUrl != "https://i.pravatar.cc/300") {
        setImage(avatarUrl);
      } else {
        setState(() {
          imageFile = "";
        });
      }
    });
  }

  setImage(String avatarUrl) async {
    Directory folderDir = await getApplicationDocumentsDirectory();
    if (!await Directory("${folderDir.path}/$userEmail").exists()) {
      await Directory("${folderDir.path}/$userEmail").create();
      Reference ref = FirebaseStorage.instance.refFromURL(avatarUrl);
      File file = File("${folderDir.path}/$userEmail/profile-avatar.png");
      await ref.writeToFile(file);
    }
    setState(() {
      imageFile = "${folderDir.path}/$userEmail/profile-avatar.png";
    });
  }

  getAvatarImage() {
    if (imageFile != "" && imageFile != "loading") {
      return FileImage(File(imageFile));
    } else if (imageFile == "") {
      return AssetImage('assets/images/profile-user.png');
    } else {
      return AssetImage('assets/images/loading.gif');
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = userName;
    final displayEmail = userEmail;
    return Drawer(
      backgroundColor: AppColors.verdementa,
      child: ListView(
        children: <Widget>[
          buildHeader(
            name: truncateWithEllipsis(10, displayName),
            email: displayEmail,
            onClicked: () => pickNewAvatarImage(),
          ),
          const SizedBox(height: 8),
          buildMenuItem(
            text: 'Home',
            icon: Icons.house,
            onClicked: () => selectedItem(context, 0),
          ),
          const SizedBox(height: 8),
          buildMenuItem(
            text: 'Tutorial',
            icon: Icons.book,
            onClicked: () => selectedItem(context, 5),
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
          ),
          const SizedBox(height: 8),
          buildMenuItem(
            text: 'Diário Livre',
            icon: Icons.book_outlined,
            onClicked: () => selectedItem(context, 8),
          ),
          const SizedBox(height: 8),
          buildMenuItem(
            text: 'Tutorial',
            icon: Icons.book,
            onClicked: () => selectedItem(context, 6),
          ),
          const SizedBox(height: 8),
          buildMenuItem(
            text: 'Editar perfil',
            icon: Icons.edit,
            onClicked: () => selectedItem(context, 7),
          ),
          const SizedBox(height: 8),
          buildMenuItem(
            text: 'Sair',
            icon: Icons.exit_to_app,
            onClicked: () {
              UserService().signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/sign-in", (Route<dynamic> route) => false);
            },
          ),
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
          // AsyncSnapshot<Your object type>
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 0, 10),
            alignment: AlignmentDirectional.topStart,
            child: Text(
              "Versão: " + version,
              style:
                  TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.3)),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      DrawerHeader(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: onClicked,
              child: CircleAvatar(
                maxRadius: 30,
                backgroundImage: getAvatarImage(),
                backgroundColor: Colors.transparent,
              ),
            ),
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
        Navigator.of(context).pushNamed("/contacts-chat-screen");
        break;
      case 5:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/tutorial");
        break;
      case 6:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/tutorial");
        break;
      case 7:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/edit-profile-screen");
        break;
      case 8:
        Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
        Navigator.of(context).pushNamed("/audio-text-diary");
        break;
    }
  }
}
