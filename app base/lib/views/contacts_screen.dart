import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../modal/contact.dart';
import '../widgets/new_contact.dart';

class ContactsScreen extends StatefulWidget {
  static const routeName = '/contacts-screen';

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<Contact> _userContacts = [
    Contact(
      name: 'Lucas',
      number: '991920513',
    ),
    Contact(
      name: 'Heidy',
      number: '991920514',
    ),
  ];

  void _addNewContact(String ncName, String ncNumber) {
    final newCt = Contact(
      name: ncName,
      number: ncNumber,
    );

    setState(() {
      _userContacts.add(newCt);
    });
  }

  void _startAddNewContact(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewContact(_addNewContact),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 15.0,
              left: 10.0,
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: [
                Text(
                  'Contatos',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'de Emergência',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185,
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
                      child: ListView.builder(
                          itemCount: _userContacts.length,
                          itemBuilder: (ctx, index) {
                            return _buildContactItem(_userContacts[index].name,
                                _userContacts[index].number);
                          }),
                    ),
                  ),
                ),
                Row(
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
                        onPressed: () => _startAddNewContact(context),
                        icon: Icon(
                          Icons.add,
                          color: Color(0xFF21BFBD),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildContactItem(String name, String number) {
  return Padding(
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
                      number,
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
              _callNumber(number);
            },
          ),
        ],
      ),
    ),
  );
}

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}
