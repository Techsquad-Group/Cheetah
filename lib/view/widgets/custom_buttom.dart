// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unnecessary_new

import 'package:flutter/material.dart';
import 'custom_text.dart';

import '../../constance.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPress;

  CustomButton({
    required this.onPress,
    this.text = 'Write text ',
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
                onPressed: onPress,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  primary: color,
                ),
                child: CustomText(
                  text: text,
                  color: Colors.white,
                  alignment: Alignment.center,
                ))
          ],
        ),
      ),
    );
  }
}
