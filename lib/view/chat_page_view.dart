// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:cheeta/core/services/firestore_chat.dart';
import 'package:cheeta/core/view_model/chat_view_model.dart';
import 'package:cheeta/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/view_model/product_view_model.dart';
import '../model/message_model.dart';

class ChatPageView extends GetWidget<ChatViewModel> {
  UserModel myUser, myFriendUser;

  ChatPageView({required this.myUser, required this.myFriendUser});

  late String chatID = Get.find<ChatViewModel>()
      .getChatId(myUser.userId as String, myFriendUser.userId);

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 80,
                padding: EdgeInsets.all(16).copyWith(left: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(color: Colors.white),
                        Expanded(
                          child: Text(
                            myFriendUser.name ?? '',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              var url = "tel:${myFriendUser.number}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: GetBuilder<ChatViewModel>(
                      init: ChatViewModel(),
                      builder: (controller) => controller.loading.value
                          ? Center(child: CircularProgressIndicator())
                          : messageHistory()),
                ),
              ),
              NewMessageWidget(myUser: myUser, myFriendUser: myFriendUser)
            ],
          ),
        ),
      );

  Widget messageHistory() {
    Get.find<ChatViewModel>().getMessages(chatID);
    return GetBuilder<ChatViewModel>(
      builder: (controller) => controller.messageModel.isEmpty
          ? Center(
              child: Text(
                'Say Hi..',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              itemCount: controller.messageModel.length,
              itemBuilder: (context, index) {
                final message = controller.messageModel[index];
                bool isMe = message.idUser == myUser.userId;

                return Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: <Widget>[
                    if (!isMe)
                      CircleAvatar(
                          radius: 16,
                          backgroundImage: message.picUser == 'default'
                              ? AssetImage('assets/images/avatar.png')
                              : message.picUser == ''
                                  ? AssetImage('assets/images/avatar.png')
                                  : NetworkImage(message.picUser)
                                      as ImageProvider),
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(16),
                      constraints: BoxConstraints(maxWidth: 140),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: isMe
                            ? BorderRadius.all(Radius.circular(12)).subtract(
                                BorderRadius.only(
                                    bottomRight: Radius.circular(12)))
                            : BorderRadius.all(Radius.circular(12)).subtract(
                                BorderRadius.only(
                                    bottomLeft: Radius.circular(12))),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            message.message,
                            style: TextStyle(color: Colors.white),
                            textAlign: isMe ? TextAlign.end : TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const MessageWidget({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isMe)
          CircleAvatar(
              radius: 16,
              backgroundImage: message.picUser == 'default'
                  ? AssetImage('assets/images/avatar.png')
                  : message.picUser == ''
                      ? AssetImage('assets/images/avatar.png')
                      : NetworkImage(message.picUser) as ImageProvider),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          constraints: BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[100] : Theme.of(context).accentColor,
            borderRadius: isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(color: isMe ? Colors.black : Colors.white),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}

class NewMessageWidget extends StatefulWidget {
  UserModel myUser, myFriendUser;

  NewMessageWidget({required this.myUser, required this.myFriendUser});

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';
  String chatId = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    await Get.find<ChatViewModel>()
        .uploadMessage(chatId, widget.myUser, message);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Message',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 20),
            GetBuilder<ChatViewModel>(
              init: ChatViewModel(),
              builder: (controller) => GestureDetector(
                onTap: () {
                  chatId = controller.getChatId(
                      widget.myUser.userId ?? '', widget.myFriendUser.userId);
                  if (message.length > 0) {
                    sendMessage();
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );
}
