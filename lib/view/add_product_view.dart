import 'package:cheeta/core/view_model/product_view_model.dart';
import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/model/user_model.dart';
import 'package:cheeta/view/home/seller_home_view.dart';
import 'package:cheeta/view/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../core/view_model/profile_view_model.dart';

class AddProductView extends GetWidget<ProductViewModel> {
  static const String _title = 'Flutter Code Sample';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void addUserDateToProduct(String seller, String sellerImg, String sellerNum) {
    controller.seller = seller;
    controller.sellerImg = sellerImg;
    controller.sellerNum = sellerNum;
  }

  void addProduct() {
    controller.saveProduct();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextFormField(
                text: "Category",
                hintText: "Enter your category",
                onSave: (value) {
                  controller.category = value!;
                },
                validator: (String? _valid) {
                  if (_valid == null || _valid.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                text: "City",
                hintText: "Enter your city",
                onSave: (value) {
                  controller.city = value!;
                },
                validator: (String? _valid) {
                  if (_valid == null || _valid.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                text: "Location",
                hintText: "Enter your location",
                onSave: (value) {
                  controller.location = value!;
                },
                validator: (String? _valid) {
                  if (_valid == null || _valid.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                text: "Price",
                hintText: "Enter your price",
                onSave: (value) {
                  controller.price = value!;
                },
                validator: (String? _valid) {
                  if (_valid == null || _valid.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                text: "Product Name",
                hintText: "Enter your product name",
                onSave: (value) {
                  controller.name = value!;
                },
                validator: (String? _valid) {
                  if (_valid == null || _valid.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                text: "Product Description",
                hintText: "Enter your product description",
                onSave: (value) {
                  controller.description = value!;
                },
                validator: (String? _valid) {
                  if (_valid == null || _valid.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              GetBuilder<ProfileViewModel>(
                init: ProfileViewModel(),
                builder: (controller) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.save();
                      if (_formKey.currentState!.validate()) {
                        addUserDateToProduct(
                            controller.userModel.name!,
                            controller.userModel.pic!,
                            controller.userModel.number == null
                                ? "none"
                                : controller.userModel.number!);
                        addProduct();
                      }
                    },
                    child: const Text('Add Product'),
                    //color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
