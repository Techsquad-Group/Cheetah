// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:cheeta/model/user_model.dart';
import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/control_view.dart';
import 'package:cheeta/view/product_view.dart';
import 'package:cheeta/view/widgets/custom_profile_tiles.dart';
import 'package:cheeta/view/widgets/custom_row_item.dart';
import 'package:cheeta/view/widgets/custom_row_my_items.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../constance.dart';
import '../core/view_model/home_view_model.dart';
import '../core/view_model/profile_view_model.dart';
import 'my_product_view.dart';

class MyItems extends StatelessWidget {
  String user;
  MyItems({required this.user});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                leading: GestureDetector(
                    onTap: () {
                      Get.off(() => ControlView());
                    },
                    child: Icon(Icons.arrow_back, color: primaryColor)),
              ),
              body: SingleChildScrollView(
                  child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.productModel.length,
                itemBuilder: (context, index) {
                  if (controller.productModel[index].sellerId == user) {
                    String name = controller.productModel[index].name!;
                    String image = controller.productModel[index].image!;
                    String price = controller.productModel[index].price!;
                    String date = controller.productModel[index].date!;
                    String productId =
                        controller.productModel[index].productId!;

                    return GestureDetector(
                        onTap: () {
                          Get.to(() => MyProductView(
                                model: controller.productModel[index],
                                productId: productId,
                              ));
                        },
                        child: CustomRowMyItems(
                          text: name,
                          image: image,
                          price: price,
                          date: date,
                          productId: productId,
                          sellerId: user,
                        ));
                  }
                  return SizedBox.shrink();
                },
              )),
            ),
    );
  }
}
