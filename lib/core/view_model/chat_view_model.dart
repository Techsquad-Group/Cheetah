import 'package:cheeta/core/services/firestore_chat.dart';
import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/model/chat_model.dart';
import 'package:cheeta/model/message_model.dart';
import 'package:cheeta/view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

import '../../model/product_model.dart';
import '../../model/user_model.dart';
import '../services/firestore_people.dart';
import '../services/firestore_product.dart';

class ChatViewModel extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<ChatModel> _chatModel = [];
  List<ChatModel> get chatModel => _chatModel;

  List<MessageModel> _messageModel = [];
  List<MessageModel> get messageModel => _messageModel;

  ChatViewModel() {
    getChat();
  }

  getChat() async {
    _loading.value = true;
    await FireStoreChat().getChats().then((value) {
      for (int i = 0; i < value.length; i++) {
        _chatModel
            .add(ChatModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }
      _loading.value = false;
      update();
    });
  }

  getChatId(String mine, myFriend) {
    String chatID = '';
    for (var i = 0; i < chatModel.length; i++) {
      if (chatModel[i].user1 == mine) {
        if (chatModel[i].user2 == myFriend) {
          chatID = chatModel[i].chatID as String;
        }
      } else if (chatModel[i].user2 == mine) {
        if (chatModel[i].user1 == myFriend) {
          chatID = chatModel[i].chatID as String;
        }
      }
    }

    return chatID;
  }

  getMessages(String chatID) async {
    _loading.value = true;
    await FireStoreChat().getMessages(chatID).then((value) {
      _messageModel.clear();
      for (int i = 0; i < value.length; i++) {
        _messageModel.add(
            MessageModel.fromJson(value[i].data() as Map<String, dynamic>));
      }
      _loading.value = false;
      update();
    });
  }

  uploadMessage(String chatId, UserModel user, String message) async {
    await FireStoreChat.uploadMessage(chatId, user, message);
    update();
  }
}
