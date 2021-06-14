import 'package:cloud_firestore/cloud_firestore.dart';

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

  disableQuest(String questId, userEmail) {
    DateTime instantTime;
    instantTime = DateTime.now();
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

  getChatRooms(String userName) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  getCreatedQuests(String userEmail) async {
    return FirebaseFirestore.instance
        .collection("Escala")
        .doc(userEmail)
        .collection("userEscalas")
        .snapshots();
  }
}