import 'package:flutter/material.dart';

import '../utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class MessageModel {
  final String idUser;
  final String picUser;
  final String message;
  final DateTime? createdAt;

  const MessageModel({
    required this.idUser,
    required this.picUser,
    required this.message,
    required this.createdAt,
  });

  static MessageModel fromJson(Map<String, dynamic> json) => MessageModel(
        idUser: json['idUser'],
        picUser: json['picUser'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'picUser': picUser,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
      };
}
