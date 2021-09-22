import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
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

  createQuest(String questId, questMap, userEmail) {
    FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
        .collection("userEscalas")
        .doc(questId)
        .set(questMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  recomendReading(String readingsId, readingsMap, userEmail) {
    FirebaseFirestore.instance
        .collection("Readings")
        .doc(userEmail)
        .collection("userReadings")
        .doc(readingsId)
        .set(readingsMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  rateReading(String readingsId, readingsMap, userEmail) {
    FirebaseFirestore.instance
        .collection("Readings")
        .doc(userEmail)
        .collection("userRatings")
        .doc(readingsId)
        .set(readingsMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  createContactList(contactMap, userEmail) {
    FirebaseFirestore.instance
        .collection("Contacts")
        .doc(userEmail)
        .collection("list")
        .add(contactMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  deleteContact(userEmail, docId) {
    CollectionReference _mainCollection =
        FirebaseFirestore.instance.collection('Contacts');

    DocumentReference documentReference =
        _mainCollection.doc(userEmail).collection('list').doc(docId);

    documentReference.delete();
  }

  updateContact(userEmail, docId, contactMap) {
    CollectionReference _mainCollection =
        FirebaseFirestore.instance.collection('Contacts');

    DocumentReference documentReference =
        _mainCollection.doc(userEmail).collection('list').doc(docId);

    documentReference.update(contactMap);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getRecomendedReadings(
      String userEmail) async {
    print("aa");
    print(userEmail);
    return FirebaseFirestore.instance
        .collection("Readings")
        .doc(userEmail)
        .collection("userReadings")
        .snapshots();
  }

  Future<QuerySnapshot> readingsAreEmpty() async {
    print("check");
    print(FirebaseAuth.instance.currentUser!.email);
    return FirebaseFirestore.instance
        .collection('Readings')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("userReadings")
        .limit(1)
        .get();
  }

  Future<QuerySnapshot> ratingsAreEmpty(String readingId) async {
    print("check");
    print(FirebaseAuth.instance.currentUser!.email);
    return FirebaseFirestore.instance
        .collection('Readings')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("userRatings")
        .where(
          "readingsId",
          isEqualTo: readingId,
        )
        .limit(1)
        .get();
  }

  disableQuest(String questId, userEmail) {
    Map<String, dynamic> disableMap = {
      "unanswered?": false,
    };

    FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
        .collection("userEscalas")
        .doc(questId)
        .update(disableMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  updateQuestIndex(String questId, String userEmail, index) {
    Map<String, dynamic> disableMap = {
      "answeredUntil": index,
    };

    FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
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

  addRespostaQuestionarioSono(String emailId, respostasMap, String data) {
    FirebaseFirestore.instance
        .collection("questionarioSono")
        .doc(emailId)
        .collection("respostas")
        .doc("${data}")
        .set(respostasMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addQuestAnswer(answerMap, userEmail, questName) {
    FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
        .collection("userEscalas")
        .doc(questName)
        .collection("answers")
        .add(answerMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getDataQuestSono(String email) async {
    return FirebaseFirestore.instance
        .collection("questionarioSono")
        .doc(email)
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

  getCreatedContacts(String email) async {
    return FirebaseFirestore.instance
        .collection("Contacts")
        .doc(email)
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
      String userEmail) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
        .collection("userEscalas")
        .snapshots();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getUnansweredQuests(
      String userEmail) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
        .collection("userEscalas")
        .where("unanswered?", isEqualTo: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAnsweredQuests(
      String userEmail) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
        .collection("userEscalas")
        .where("unanswered?", isEqualTo: false)
        .snapshots();
  }

  getDomFromAnswers(String userEmail, String userEscala, String dom) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
        .collection("userEscalas")
        .doc(userEscala)
        .collection("answers")
        .orderBy(dom, descending: true)
        .limit(1)
        .get();
  }
}
