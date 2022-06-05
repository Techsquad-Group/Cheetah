import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final String image;

  CustomCard({
    this.text = "",
    this.image = "",
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
            child: Column(
              children: [
                Container(
                    child: Image.network(
                  image,
                  fit: BoxFit.fill,
                )),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: text,
                  fontSize: 25,
                  alignment: Alignment.center,
                ),
              ],
            ),
          )),
    );
  }
}
