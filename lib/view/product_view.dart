// ignore_for_file: deprecated_member_use

import 'package:cheeta/view/widgets/custom_buttom.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constance.dart';
import '../model/product_model.dart';

class ProductView extends StatelessWidget {
  ProductModel model;

  ProductView({required this.model});

  @override
  Widget build(BuildContext context) {
    String name = model.name!;
    String image = model.image!;
    String price = model.price!;
    String city = model.city!;
    String location = model.location!;
    String description = model.description!;
    String date = model.date!;
    String seller = model.seller!;
    String sellerImg = model.sellerImg!;
    String sellerNum = model.sellerNum!;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: name,
                            fontSize: 25,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.favorite),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: 'RM $price',
                        fontSize: 15,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: '$city , $location',
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                          CustomText(
                            text: '$date',
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Image.network(
                                  sellerImg,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              CustomText(
                                text: '$seller',
                                fontSize: 16,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var url = "tel:$sellerNum";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Icon(Icons.call),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var url =
                                      "https://wa.me/?text=Hello, I would like to buy your $name";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Icon(Icons.whatsapp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade700),
                      CustomText(text: "Description", fontSize: 15),
                      SizedBox(
                        height: 5,
                      ),
                      CustomText(text: description, fontSize: 12),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
