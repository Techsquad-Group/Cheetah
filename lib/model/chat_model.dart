// ignore_for_file: unnecessary_null_comparison

class ChatModel {
  String? user1, user2, chatID;

  ChatModel({this.user1, this.user2, this.chatID});

  ChatModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    user1 = map['user1'];
    user2 = map['user2'];
    chatID = map['chatID'];
  }

  toJson() {
    return {
      'user1': user1,
      'user2': user2,
      'chatID': chatID,
    };
  }
}
