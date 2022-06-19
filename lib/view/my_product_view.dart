// ignore_for_file: deprecated_member_use

import 'package:cheeta/view/control_view.dart';
import 'package:cheeta/view/my_items_view.dart';
import 'package:cheeta/view/widgets/custom_buttom.dart';
import 'package:cheeta/view/widgets/custom_edit_form_feild.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:cheeta/view/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constance.dart';
import '../core/view_model/home_view_model.dart';
import '../core/view_model/product_view_model.dart';
import '../model/product_model.dart';

class MyProductView extends StatelessWidget {
  ProductModel model;
  String productId;

  MyProductView({
    required this.model,
    required this.productId,
  });

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController desController = TextEditingController();
  String currentDate = new DateFormat('yyyy-MM-dd').format(new DateTime.now());

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
    String sellerId = model.sellerId!;
    String sellerImg = model.sellerImg!;
    String sellerNum = model.sellerNum!;

    return GetBuilder<HomeViewModel>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.off(() => MyItems(
                      sellerId: sellerId,
                    ));
              },
              child: Icon(Icons.arrow_back, color: primaryColor)),
        ),
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
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 130,
                              child: CustomButton(
                                onPress: () {
                                  nameController.text = name;
                                  priceController.text = price;
                                  desController.text = description;

                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(40.0),
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    CustomEditProductFeild(
                                                      controller:
                                                          nameController,
                                                      labelText: 'Name',
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomEditProductFeild(
                                                      controller:
                                                          priceController,
                                                      labelText: 'Price',
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    CustomEditProductFeild(
                                                      controller: desController,
                                                      labelText: 'Description',
                                                    ),
                                                    SizedBox(
                                                      height: 60,
                                                    ),
                                                    CustomButton(
                                                      color: Colors.green,
                                                      onPress: () {
                                                        controller
                                                            .updateProduct(
                                                                productId,
                                                                currentDate,
                                                                nameController
                                                                    .text,
                                                                priceController
                                                                    .text,
                                                                desController
                                                                    .text);
                                                        Get.off(() => MyItems(
                                                              sellerId:
                                                                  sellerId,
                                                            ));
                                                      },
                                                      text: "Update Info",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                },
                                text: "Edit",
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              width: 150,
                              child: CustomButton(
                                onPress: () {
                                  controller.deleteProduct(productId);
                                  Get.off(() => MyItems(
                                        sellerId: sellerId,
                                      ));
                                },
                                text: "Delete",
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
