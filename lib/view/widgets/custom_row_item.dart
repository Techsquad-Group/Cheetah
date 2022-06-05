import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRowItem extends StatelessWidget {
  final String text, image, price, date;

  CustomRowItem({
    this.text = "",
    this.image = "",
    this.price = "",
    this.date = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(71, 13, 12, 12),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: text,
                                fontSize: 25,
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "Price RM$price",
                                fontSize: 14,
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          CustomText(
                            text: "$date   ",
                            fontSize: 14,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
