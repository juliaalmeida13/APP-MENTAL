import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class DatabaseMethods {
  static types.User? chatUser;

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future createReadingsDoc(String uid) async {
    return await FirebaseFirestore.instance
        .collection("Readings")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "CreatedOn": Timestamp.now().toString(),
    });
  }

  Future createContactsDoc(String uid) async {
    return await FirebaseFirestore.instance
        .collection("Contacts")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "CreatedOn": Timestamp.now().toString(),
    });
  }

  Future createQuestDoc(String uid) async {
    return await FirebaseFirestore.instance
        .collection("questionarioSono")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "CreatedOn": Timestamp.now().toString(),
    });
  }

  Future createEscalaDoc(String uid) async {
    return await FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "CreatedOn": Timestamp.now().toString(),
    });
  }

  createQuest(String questId, questMap, uid) {
    FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .doc(questId)
        .set(questMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  recomendReading(String readingsId, readingsMap, uid) {
    FirebaseFirestore.instance
        .collection("Readings")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userReadings")
        .doc(readingsId)
        .set(readingsMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  rateReading(String readingsId, readingsMap, uid) {
    FirebaseFirestore.instance
        .collection("Readings")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userRatings")
        .doc(readingsId)
        .set(readingsMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<types.User> getFirstContact() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    var value = await FirebaseFirestore.instance
        .collection("users")
        .where("role", isEqualTo: "agent")
        .get();
    if (value.docs.length == 0 || value.docs[0].data() == null) {
      return Future.error(
          "Falha ao pegar dados relacionados ao chat do usuário");
    }
    final data = value.docs[0].data();
    data['id'] = value.docs[0].id;
    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;
    final user = types.User.fromJson(data);
    return user;
  }

  /// Fetches user from Firebase and returns a promise
  Future<types.User?> fetchUser() async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final data = doc.data();
    if (data == null) {
      return Future.error(
          "Falha ao pegar dados relacionados ao chat do usuário");
    }

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;
    chatUser = types.User.fromJson(data);
    return chatUser;
  }

  /// Fetches user from Firebase and returns a promise
  Future<types.User?> fetchUserByFirebaseUser(User user) async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    final data = doc.data();
    if (data == null) {
      return Future.error(
          "Falha ao pegar dados relacionados ao chat do usuário");
    }
    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;
    chatUser = types.User.fromJson(data);
    return chatUser;
  }

  createContactList(contactMap, uid) {
    FirebaseFirestore.instance
        .collection("Contacts")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("list")
        .add(contactMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  deleteContact(uid, docId) {
    CollectionReference _mainCollection =
        FirebaseFirestore.instance.collection('Contacts');

    DocumentReference documentReference =
        _mainCollection.doc(uid).collection('list').doc(docId);

    documentReference.delete();
  }

  updateContact(uid, docId, contactMap) {
    CollectionReference _mainCollection =
        FirebaseFirestore.instance.collection('Contacts');

    DocumentReference documentReference =
        _mainCollection.doc(uid).collection('list').doc(docId);

    documentReference.update(contactMap);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getRecomendedReadings() async {
    return FirebaseFirestore.instance
        .collection("Readings")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userReadings")
        .snapshots();
  }

  Future<QuerySnapshot> readingsAreEmpty() async {
    print("check");
    return FirebaseFirestore.instance
        .collection('Readings')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userReadings")
        .limit(1)
        .get();
  }

  Future<QuerySnapshot> ratingsAreEmpty(String readingId) async {
    print("check");
    print(FirebaseAuth.instance.currentUser!.uid);
    return FirebaseFirestore.instance
        .collection('Readings')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userRatings")
        .where(
          "readingsId",
          isEqualTo: readingId,
        )
        .limit(1)
        .get();
  }

  disableQuest(String questId, uid) {
    Map<String, dynamic> disableMap = {
      "unanswered?": false,
    };

    FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .doc(questId)
        .update(disableMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  updateQuestIndex(String questId, String uid, index) {
    Map<String, dynamic> disableMap = {
      "answeredUntil": index,
    };

    FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .doc(questId)
        .update(disableMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addRespostaQuestionarioSono(String uid, respostasMap, String data) {
    FirebaseFirestore.instance
        .collection("questionarioSono")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("respostas")
        .doc("${data}")
        .set(respostasMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addQuestAnswer(answerMap, uid, questName) {
    FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .doc(questName)
        .collection("answers")
        .add(answerMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getDataQuestSonoFromAll() async {
    return FirebaseFirestore.instance.collection("questionarioSono").get();
  }

  getDataQuestSono(String uid) async {
    return FirebaseFirestore.instance
        .collection("questionarioSono")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("respostas")
        .get();
  }

  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getCreatedContacts(String uid) async {
    return FirebaseFirestore.instance
        .collection("Contacts")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("list")
        .orderBy('name')
        .snapshots();
  }

  getChatRooms(String userName) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getCreatedQuests(
      String uid) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .snapshots();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getUnansweredQuests(
      String uid) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .where("unanswered?", isEqualTo: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAnsweredQuests(
      String uid) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .where("unanswered?", isEqualTo: false)
        .snapshots();
  }

  getDomFromAnswers(String uid, String userEscala, String dom) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .doc(userEscala)
        .collection("answers")
        .orderBy(dom, descending: true)
        .limit(1)
        .get();
  }

  getDomTotal(
    String userEscala,
    String dom,
  ) async {
    var doms = List<double>.filled(14, 0);
    await FirebaseFirestore.instance
        .collection("Escala")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userEscalas")
        .doc(userEscala)
        .collection("answers")
        .orderBy(dom, descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doms[1] += doc['dom1'].toDouble();
        doms[2] += doc['dom2'].toDouble();
        doms[3] += doc['dom3'].toDouble();
        doms[4] += doc['dom4'].toDouble();
        doms[5] += doc['dom5'].toDouble();
        doms[6] += doc['dom6'].toDouble();
        doms[7] += doc['dom7'].toDouble();
        doms[8] += doc['dom8'].toDouble();
        doms[9] += doc['dom9'].toDouble();
        doms[10] += doc['dom10'].toDouble();
        doms[11] += doc['dom11'].toDouble();
        doms[12] += doc['dom12'].toDouble();
        doms[13] += doc['dom13'].toDouble();
      });
    });
    return doms;
  }
}
