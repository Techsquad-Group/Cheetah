import 'package:cheeta/constance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomEditProductFeild extends StatelessWidget {
  TextEditingController controller;
  String labelText;

  CustomEditProductFeild({
    this.labelText = "",
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: primaryColor),
            border: InputBorder.none),
      ),
    );
  }
}
