import 'dart:async';

import 'package:cheeta/model/chat_model.dart';
import 'package:cheeta/model/message_model.dart';
import 'package:cheeta/model/user_model.dart';
import 'package:cheeta/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreChat {
  final CollectionReference _chatCollectionRef =
      FirebaseFirestore.instance.collection('Chats');

  void addChatToFireStore(ChatModel chatModel) async {
    List<String> ids = [chatModel.user1.toString(), chatModel.user2.toString()];
    ids.sort();
    String theID = ids[0].substring(0, 10) + ids[1].substring(10);

    await _chatCollectionRef.doc(theID).set(chatModel.toJson());
  }

  Future<List<QueryDocumentSnapshot>> getChats() async {
    var value = await _chatCollectionRef.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getMessages(String chatID) async {
    var value = await FirebaseFirestore.instance
        .collection('Messages/$chatID/messages')
        .orderBy(MessageField.createdAt, descending: true)
        .get();
    return value.docs;
  }

  static Future uploadMessage(
      String chatId, UserModel user, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('Messages/$chatId/messages');

    final newMessage = MessageModel(
      idUser: user.userId ?? '',
      picUser: user.pic ?? '',
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());
  }
}
