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
import '../core/view_model/profile_view_model.dart';
import '../model/product_model.dart';

class EditProfile extends StatelessWidget {
  String user;

  EditProfile({
    required this.user,
  });

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.off(() => ControlView());
              },
              child: Icon(Icons.arrow_back, color: primaryColor)),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: controller.userModel == null
                        ? AssetImage(
                            'assets/images/avatar.png',
                          )
                        : controller.userModel.pic == 'default'
                            ? AssetImage('assets/images/avatar.png')
                            : controller.userModel.pic == ''
                                ? AssetImage('assets/images/avatar.png')
                                : controller.userModel.pic == null
                                    ? AssetImage('assets/images/avatar.png')
                                    : NetworkImage(
                                        controller.userModel.pic ?? '',
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Name    :   ',
                              fontSize: 20,
                            ),
                            CustomText(
                              text: controller.userModel.name ?? '',
                              fontSize: 20,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Email     :   ',
                              fontSize: 20,
                            ),
                            CustomText(
                              text: controller.userModel.email ?? '',
                              fontSize: 20,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Number :   ',
                              fontSize: 20,
                            ),
                            CustomText(
                              text: controller.userModel.number ?? '',
                              fontSize: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 130,
                              child: CustomButton(
                                onPress: () {
                                  nameController.text =
                                      controller.userModel.name ?? '';
                                  numberController.text =
                                      controller.userModel.number ?? '';

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
                                                          numberController,
                                                      labelText: 'Number',
                                                    ),
                                                    SizedBox(
                                                      height: 60,
                                                    ),
                                                    CustomButton(
                                                      color: Colors.green,
                                                      onPress: () {
                                                        if (controller.userModel
                                                                .registeredWith ==
                                                            'normal') {
                                                          controller
                                                              .updateProfile(
                                                            user,
                                                            nameController.text,
                                                            numberController
                                                                .text,
                                                          );
                                                          Get.off(() => MyItems(
                                                                user: user,
                                                              ));
                                                        } else {
                                                          Get.snackbar(
                                                              "Must ber registered first to edit information",
                                                              "",
                                                              colorText:
                                                                  Colors.black,
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM);
                                                        }
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
                                  controller.deleteProfile(user);
                                  Get.off(() => MyItems(
                                        user: user,
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
