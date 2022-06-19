// ignore_for_file: deprecated_member_use

import 'package:cheeta/view/control_view.dart';
import 'package:cheeta/view/widgets/custom_buttom.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constance.dart';
import '../core/view_model/people_view_model.dart';
import '../core/view_model/product_view_model.dart';
import '../model/product_model.dart';
import 'online_profile_view.dart';

class ProductView extends StatelessWidget {
  ProductModel model;

  ProductView({required this.model});

  @override
  Widget build(BuildContext context) {
    String name = model.name ?? '';
    String image = model.image ?? '';
    String price = model.price ?? '';
    String city = model.city ?? '';
    String location = model.location ?? '';
    String description = model.description ?? '';
    String date = model.date ?? '';
    String seller = model.seller ?? '';
    String sellerId = model.sellerId ?? '';
    String sellerImg = model.sellerImg ?? '';
    String sellerNum = model.sellerNum ?? '';

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
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
                          GetBuilder<PeopleViewModel>(
                            init: PeopleViewModel(),
                            builder: (controller) => GestureDetector(
                              onTap: () {
                                controller.getSpecificUser(sellerId);
                                Get.to(() => OnlineProfileView(
                                      userModel: controller.singleUserModel,
                                    ));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: sellerImg == ''
                                            ? AssetImage(
                                                'assets/images/avatar.png',
                                              )
                                            : NetworkImage(
                                                sellerImg,
                                              ) as ImageProvider,
                                        fit: BoxFit.fill,
                                      ),
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
                            ),
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
