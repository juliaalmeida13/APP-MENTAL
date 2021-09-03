import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:app_mental/constants.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactsScreen extends StatefulWidget {
  static const routeName = '/contacts-screen';

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  late Stream<QuerySnapshot<Object?>> contactsRoomsStream = new Stream.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.green,
        shadowColor: Colors.transparent,
        title: Text("Contatos"),
      ),
      backgroundColor: AppColors.green,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                )),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(
                left: 25.0,
                right: 20.0,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 45.0),
                  child: Container(
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
                                      snapshot.data!.docs[index].get("name"),
                                      snapshot.data!.docs[index].get("number"),
                                    );
                                  },
                                )
                              : Container();
                        },
                      ),
                    ),
                  ),
                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: OutlinedButton.icon(
                        label: Text(
                          'Adicionar novo contato',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Color(0xFF21BFBD),
                            fontSize: 15.0,
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Color(0xFF21BFBD),
                        ),
                      ),
                    ),
                  ],
                )*/
              ],
            ),
          )
        ],
      ),
    );
  }

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
    databaseMethods.getCreatedContacts(Constants.myEmail).then((val) {
      setState(() {
        contactsRoomsStream = val;
      });
    });

    setState(() {});
  }
}

Widget _buildContactItem(String name, int number) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      width: 335,
      height: 50,
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
                offset: Offset(0, 4),
                blurRadius: 4)
          ]),
      child: Padding(
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.0,
        ),
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
  );
}

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}
