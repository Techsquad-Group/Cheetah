// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unnecessary_new

import 'package:flutter/material.dart';
import 'custom_text.dart';

import '../../constance.dart';

class CustomButtonWithoutBackground extends StatelessWidget {
  final String text;
  final Color color;
  final Alignment alignment;
  final double fontSize;
  final VoidCallback onPress;

  CustomButtonWithoutBackground({
    required this.onPress,
    this.text = '',
    this.color = primaryColor,
    this.alignment = Alignment.center,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
            onPressed: onPress,
            child: CustomText(
              text: text,
              color: color,
              fontSize: fontSize,
              alignment: alignment,
            )));
  }
}
