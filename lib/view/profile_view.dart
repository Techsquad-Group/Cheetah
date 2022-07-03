// ignore_for_file: unnecessary_null_comparison

import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/favorite_view.dart';
import 'package:cheeta/view/product_view.dart';
import 'package:cheeta/view/widgets/custom_profile_tiles.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../core/view_model/profile_view_model.dart';
import 'edit_profile_view.dart';
import 'my_items_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
        init: ProfileViewModel(),
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
                                image: controller.userModel == null
                                    ? AssetImage(
                                        'assets/images/avatar.png',
                                      )
                                    : controller.userModel.pic == 'default'
                                        ? AssetImage('assets/images/avatar.png')
                                        : controller.userModel.pic == ''
                                            ? AssetImage(
                                                'assets/images/avatar.png')
                                            : controller.userModel.pic == null
                                                ? AssetImage(
                                                    'assets/images/avatar.png')
                                                : NetworkImage(
                                                    controller.userModel.pic ??
                                                        '',
                                                  ) as ImageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              CustomText(
                                text: controller.userModel.name ?? '',
                                color: Colors.black,
                                fontSize: 32,
                              ),
                              CustomText(
                                text: controller.userModel.email ?? '',
                                color: Colors.black,
                                fontSize: 24,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    CustomProfileTiles(
                      text: "Edit Profile",
                      image: 'assets/images/editProfile.png',
                      onPress: () {
                        Get.to(() => EditProfile(
                              user: controller.userModel.userId ?? '',
                            ));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfileTiles(
                      text: "My Items",
                      image: 'assets/images/myItems.png',
                      onPress: () {
                        Get.to(() => MyItems(
                              user: controller.userModel.userId ?? '',
                            ));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfileTiles(
                      text: "Favorite",
                      image: 'assets/images/favorite.png',
                      onPress: () {
                        Get.to(() => FavoriteView(
                              user: controller.userModel.userId ?? '',
                            ));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfileTiles(
                      text: "SignOut",
                      image: 'assets/images/signout.png',
                      onPress: () {
                        controller.signOut();
                        Get.offAll(() => LoginView());
                      },
                    ),
                  ],
                )),
              )));
  }
}
