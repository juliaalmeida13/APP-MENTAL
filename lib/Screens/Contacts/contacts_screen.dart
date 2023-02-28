import 'package:app_mental/Services/contactService.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:app_mental/model/contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatefulWidget {
  static const routeName = '/contacts-screen';

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  late List<Contact> contactList = new List.empty();

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

    this._searchContacts();
  }

  _searchContacts() {
    ContactService().findContactByUser(Constants.myEmail).then((contacts) => {
          setState(() {
            contactList = contacts;
          })
        });
  }

  _addContact(nameContact, numberContact) async {
    ContactService()
        .saveContact(nameContact.text, numberContact.text, Constants.myEmail)
        .then((_) {
      this._searchContacts();
    });
  }

  addContactDialog(
      BuildContext context, _formKey, nameContact, numberContact) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              // overflow: Overflow.visible,
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

  Widget _buildContactItem(BuildContext context, String name, String number, id,
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

  _confirmDelDialog(BuildContext context, id) async {
    Widget cancelaButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = TextButton(
      child: Text("Excluir"),
      onPressed: () {
        ContactService().deleteContact(id, Constants.myEmail).then((_) {
          this._searchContacts();
          Navigator.of(context).pop();
        });
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

  editContactDialog(BuildContext context, _formKey, name, number, id,
      nameContact, numberContact) async {
    nameContact.text = name;
    numberContact.text = number.toString();
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              // overflow: Overflow.visible,
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

  _updateContact(nameContact, numberContact, id) async {
    ContactService()
        .editContact(
            id, Constants.myEmail, nameContact.text, numberContact.text)
        .then((_) {
      this._searchContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.green,
          shadowColor: Colors.transparent,
          title: Text("Contatos"),
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
                      child: contactList.length > 0
                          ? ListView.builder(
                              itemCount: contactList.length,
                              itemBuilder: (context, index) {
                                return _buildContactItem(
                                    context,
                                    contactList[index].name,
                                    contactList[index].number,
                                    contactList[index].id,
                                    _formKey,
                                    nameContact,
                                    numberContact);
                              },
                            )
                          : Container()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  launch("tel://${number}");
}
