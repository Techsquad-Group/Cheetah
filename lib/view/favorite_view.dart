// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:cheeta/core/view_model/favorite_view_model.dart';
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

class FavoriteView extends StatelessWidget {
  String user;
  FavoriteView({required this.user});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteViewModel());
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
                itemCount:
                    Get.find<FavoriteViewModel>().allFavoriteModel.length,
                itemBuilder: (context, index) {
                  if (Get.find<FavoriteViewModel>()
                          .allFavoriteModel[index]
                          .user ==
                      user) {
                    for (var i = 0; i < controller.productModel.length; i++) {
                      if (Get.find<FavoriteViewModel>()
                              .allFavoriteModel[index]
                              .product ==
                          controller.productModel[i].productId) {
                        String name = controller.productModel[i].name!;
                        String image = controller.productModel[i].image!;
                        String price = controller.productModel[i].price!;
                        String date = controller.productModel[i].date!;
                        String productId =
                            controller.productModel[i].productId!;

                        return GestureDetector(
                            onTap: () {
                              Get.to(() => ProductView(
                                    model: Get.find<HomeViewModel>()
                                        .productModel[i],
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
                    }
                  }
                  return SizedBox.shrink();
                },
              )),
            ),
    );
  }
}
