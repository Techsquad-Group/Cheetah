// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unnecessary_new

import 'package:flutter/material.dart';
import 'custom_text.dart';

import '../../constance.dart';

class CustomButtonSocial extends StatelessWidget {
  final String text;
  final String imgName;
  final Color color;
  final double fontSize;
  final VoidCallback onPress;

  CustomButtonSocial({
    required this.onPress,
    this.imgName = '',
    this.text = '',
    this.color = primaryColor,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
        ),
        child: TextButton(
          onPressed: onPress,
          child: Row(children: [
            SizedBox(
              width: 50,
            ),
            Image.asset(imgName),
            SizedBox(
              width: 50,
            ),
            CustomText(
              text: text,
              fontSize: fontSize,
            )
          ]),
        ));
  }
}
