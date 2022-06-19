import 'package:cheeta/core/view_model/home_view_model.dart';
import 'package:cheeta/view/my_items_view.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/view_model/product_view_model.dart';
import '../control_view.dart';

class CustomRowMyItems extends StatelessWidget {
  final String text, image, price, date, category, productId, sellerId;

  CustomRowMyItems({
    this.text = "",
    this.image = "",
    this.price = "",
    this.date = "",
    this.category = "",
    this.productId = '',
    this.sellerId = '',
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
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: image == ''
                                      ? AssetImage(
                                          'assets/images/default.jpg',
                                        )
                                      : NetworkImage(
                                          image,
                                        ) as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: category,
                                fontSize: 18,
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                text: text,
                                fontSize: 24,
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
