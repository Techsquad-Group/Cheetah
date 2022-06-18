import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomProfileTiles extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onPress;

  CustomProfileTiles({
    this.text = "",
    this.image = 'assets/images/default.jpg',
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: onPress,
        child: ListTile(
          title: CustomText(
            text: text,
          ),
          leading: Image.asset(image),
          trailing: Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
