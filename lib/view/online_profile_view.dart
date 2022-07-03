// ignore_for_file: unnecessary_null_comparison

import 'package:cheeta/model/user_model.dart';
import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/product_view.dart';
import 'package:cheeta/view/widgets/custom_profile_tiles.dart';
import 'package:cheeta/view/widgets/custom_row_item.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../core/view_model/home_view_model.dart';
import '../core/view_model/people_view_model.dart';
import '../core/view_model/profile_view_model.dart';
import 'edit_profile_view.dart';
import 'my_items_view.dart';

class OnlineProfileView extends StatelessWidget {
  UserModel userModel;

  OnlineProfileView({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PeopleViewModel>(
      init: PeopleViewModel(),
      builder: (controller) => controller.loading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Container(
                padding: EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                image: DecorationImage(
                                  image: userModel == null
                                      ? AssetImage(
                                          'assets/images/avatar.png',
                                        )
                                      : userModel.pic == 'default'
                                          ? AssetImage(
                                              'assets/images/avatar.png')
                                          : userModel.pic == ''
                                              ? AssetImage(
                                                  'assets/images/avatar.png')
                                              : userModel.pic == null
                                                  ? AssetImage(
                                                      'assets/images/avatar.png')
                                                  : NetworkImage(
                                                      userModel.pic ?? '',
                                                    ) as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                CustomText(
                                  text: userModel.name ?? '',
                                  color: Colors.black,
                                  fontSize: 32,
                                ),
                                CustomText(
                                  text: userModel.email ?? '',
                                  color: Colors.black,
                                  fontSize: 24,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      GetBuilder<HomeViewModel>(
                        init: HomeViewModel(),
                        builder: (controller) => SingleChildScrollView(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.productModel.length,
                            itemBuilder: (context, index) {
                              String name =
                                  controller.productModel[index].name!;
                              String image =
                                  controller.productModel[index].image!;
                              String price =
                                  controller.productModel[index].price!;
                              String date =
                                  controller.productModel[index].date!;

                              if (controller.productModel[index].sellerId ==
                                  userModel.userId) {
                                return GestureDetector(
                                    onTap: () {
                                      Get.to(() => ProductView(
                                            model:
                                                controller.productModel[index],
                                          ));
                                    },
                                    child: CustomRowItem(
                                      text: name,
                                      image: image,
                                      price: price,
                                      date: date,
                                    ));
                              }
                              return SizedBox.shrink();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
