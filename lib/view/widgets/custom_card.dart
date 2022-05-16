import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;

  CustomCard({
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(text, style: TextStyle(fontSize: 25)),
        ),
      ),
    );
  }
}
