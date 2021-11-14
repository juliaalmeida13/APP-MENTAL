import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatefulWidget {
  static const routeName = '/contacts-screen';

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  late Stream<QuerySnapshot<Object?>> contactsRoomsStream = new Stream.empty();

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameContact = TextEditingController();
  TextEditingController numberContact = TextEditingController();

  // ↓ hold tap position, set during onTapDown, using getPosition() method
  late Offset tapXY;
  // ↓ hold screen size, using first line in build() method
  late RenderBox overlay;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameInSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailInSharedPreference();
    Constants.myEmail = Constants.myEmail.trim();
    print(Constants.myEmail);
    databaseMethods
        .getCreatedContacts(FirebaseAuth.instance.currentUser!.uid)
        .then((val) {
      setState(() {
        contactsRoomsStream = val;
      });
    });
  }

  Widget _buildContactItem(BuildContext context, String name, int number, id,
      _formKey, nameContact, numberContact) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTapDown: getPosition,
        onLongPress: () {
          showMenu(
            context: context,
            position: relRectSize,
            items: [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.edit),
                    Text("Editar"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.delete),
                    Text("Deletar"),
                  ],
                ),
              )
            ],
          ).then<void>((value) {
            if (value == 1) {
              print('Editando ${name}');
              editContactDialog(context, _formKey, name, number, id,
                  nameContact, numberContact);
            } else if (value == 2) {
              print('Deletando ${name}');
              _confirmDelDialog(context, id);
            }
          });
        },
        child: Container(
          width: 335,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: AppColors.cinza,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 1),
                    blurRadius: 4)
              ]),
          child: Padding(
            padding:
                EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              number.toString(),
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    color: Colors.black,
                    onPressed: () {
                      _callNumber(number.toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ↓ create the RelativeRect from size of screen and where you tapped
  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY & const Size(40, 40), overlay.size);

  // ↓ get the tap position Offset
  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    return Scaffold(
      drawer: AppDrawer(key: Key("drawer")),
      appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: AppColors.verdeclaro,
          elevation: 0,
          title: Text(
            'Contatos',
            style: AppTextStyles.tituloatividades,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Adicionar',
              onPressed: () {
                addContactDialog(context, _formKey, nameContact, numberContact);
              },
            )
          ]),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 300.0,
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: contactsRoomsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return _buildContactItem(
                                      context,
                                      snapshot.data!.docs[index].get("name"),
                                      snapshot.data!.docs[index].get("number"),
                                      snapshot.data!.docs[index].id,
                                      _formKey,
                                      nameContact,
                                      numberContact);
                                },
                              )
                            : Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

_confirmDelDialog(BuildContext context, id) async {
  Widget cancelaButton = TextButton(
    style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.white),
        backgroundColor: MaterialStateProperty.all(AppColors.verdementa)),
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continuaButton = TextButton(
    style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.white),
        backgroundColor: MaterialStateProperty.all(AppColors.verdementa)),
    child: Text("Excluir"),
    onPressed: () {
      DatabaseMethods()
          .deleteContact(FirebaseAuth.instance.currentUser!.uid, id);
      Navigator.of(context).pop();
    },
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Excluir Contato"),
    content: Text("Deseja realmente excluir o contato?"),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  launch("tel://${number}");
}

_addContact(nameContact, numberContact) async {
  Map<String, dynamic> contactMap = {
    "name": nameContact.text,
    "number": int.parse(numberContact.text),
  };
  DatabaseMethods()
      .createContactList(contactMap, FirebaseAuth.instance.currentUser!.uid);
}

_updateContact(nameContact, numberContact, id) async {
  Map<String, dynamic> contactMap = {
    "name": nameContact.text,
    "number": int.parse(numberContact.text),
  };
  DatabaseMethods()
      .updateContact(FirebaseAuth.instance.currentUser!.uid, id, contactMap);
}

editContactDialog(BuildContext context, _formKey, name, number, id, nameContact,
    numberContact) async {
  nameContact.text = name;
  numberContact.text = number.toString();
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: nameContact,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'vazio';
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: numberContact,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'vazio';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.verdementa),
                        child: Text("Alterar"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _updateContact(nameContact, numberContact, id);
                            nameContact.clear();
                            numberContact.clear();
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

addContactDialog(
    BuildContext context, _formKey, nameContact, numberContact) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nameContact,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'vazio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Nome',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: numberContact,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'vazio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Número',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.verdementa),
                        child: Text("Adicionar"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _addContact(nameContact, numberContact);
                            nameContact.clear();
                            numberContact.clear();
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
