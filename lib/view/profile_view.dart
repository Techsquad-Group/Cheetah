// ignore_for_file: unnecessary_null_comparison

import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../core/view_model/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
        init: ProfileViewModel(),
        builder: (controller) => Scaffold(
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
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.red,
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
                                      : NetworkImage(
                                          controller.userModel.pic!,
                                        ) as ImageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: controller.userModel.name!,
                              color: Colors.black,
                              fontSize: 32,
                            ),
                            CustomText(
                              text: controller.userModel.email!,
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
                  Container(
                    child: TextButton(
                      onPressed: () {},
                      child: ListTile(
                        title: CustomText(
                          text: "Edit Profile",
                        ),
                        leading: Image.asset('assets/images/editProfile.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        controller.signOut();
                      },
                      child: ListTile(
                        title: CustomText(
                          text: "SignOut",
                        ),
                        leading: Image.asset('assets/images/signout.png'),
                      ),
                    ),
                  ),
                ],
              )),
            )));
  }
}
