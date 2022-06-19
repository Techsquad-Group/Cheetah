// ignore_for_file: unused_local_variable
import 'package:cheeta/core/view_model/control_view_model.dart';
import 'package:cheeta/core/view_model/home_view_model.dart';
import 'package:cheeta/core/view_model/product_view_model.dart';
import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/model/user_model.dart';
import 'package:cheeta/view/control_view.dart';
import 'package:cheeta/view/home_view.dart';
import 'package:cheeta/view/product_view.dart';
import 'package:cheeta/view/widgets/custom_buttom.dart';
import 'package:cheeta/view/widgets/custom_row_item.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:cheeta/view/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/view_model/profile_view_model.dart';

class AddProductView extends GetWidget<ProductViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void addUserDateToProduct(
      String seller, String sellerId, String sellerImg, String sellerNum) {
    controller.seller = seller;
    controller.sellerId = sellerId;
    controller.sellerImg = sellerImg;
    controller.sellerNum = sellerNum;
  }

  void addProduct() {
    controller.saveProduct();
    Get.to(() => ProductView(
          model: controller.productModel,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        toolbarHeight: 80,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextFormField(
                text: "Category",
                hintText: "Enter your category",
                onSave: (value) {
                  controller.category = value!;
                },
                validator: 'Please enter some text',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                text: "City",
                hintText: "Enter your city",
                onSave: (value) {
                  controller.city = value!;
                },
                validator: 'Please enter some text',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                text: "Location",
                hintText: "Enter your location",
                onSave: (value) {
                  controller.location = value!;
                },
                validator: 'Please enter some text',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                text: "Price",
                hintText: "Enter your price",
                onSave: (value) {
                  controller.price = value!;
                },
                validator: 'Please enter some text',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                text: "Product Name",
                hintText: "Enter your product name",
                onSave: (value) {
                  controller.name = value!;
                },
                validator: 'Please enter some text',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                text: "Product Description",
                hintText: "Enter your product description",
                onSave: (value) {
                  controller.description = value!;
                },
                validator: 'Please enter some text',
              ),
              Center(
                child: GetBuilder<ProfileViewModel>(
                  init: ProfileViewModel(),
                  builder: (controller) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 100, left: 100),
                      child: CustomButton(
                        onPress: () {
                          _formKey.currentState?.save();
                          if (_formKey.currentState!.validate()) {
                            addUserDateToProduct(
                              controller.userModel.name!,
                              controller.userModel.userId!,
                              controller.userModel.pic == null
                                  ? ""
                                  : controller.userModel.pic ?? '',
                              controller.userModel.number == null
                                  ? ""
                                  : controller.userModel.number ?? '',
                            );
                            addProduct();
                          }
                        },
                        text: 'Add Product',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
