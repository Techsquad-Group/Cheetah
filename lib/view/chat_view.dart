import 'package:cheeta/core/services/firestore_chat.dart';
import 'package:cheeta/core/view_model/chat_view_model.dart';
import 'package:cheeta/core/view_model/people_view_model.dart';
import 'package:cheeta/core/view_model/profile_view_model.dart';
import 'package:cheeta/view/chat_page_view.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../core/view_model/home_view_model.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          toolbarHeight: 80,
          title: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: CustomText(
                  text: "Chat",
                  alignment: Alignment.center,
                  fontSize: 36,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: GetBuilder<PeopleViewModel>(
            init: PeopleViewModel(),
            builder: (controller) => controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.userModel.length,
                        itemBuilder: (context, index) {
                          Get.put(ProfileViewModel());
                          if (!Get.put(ProfileViewModel()).loading.value) {
                            if (controller.userModel[index].userId !=
                                Get.find<ProfileViewModel>().userModel.userId) {
                              String name =
                                  controller.userModel[index].name ?? '';
                              String pic =
                                  controller.userModel[index].pic ?? '';

                              return Container(
                                height: 75,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(
                                      () => ChatPageView(
                                        myUser: Get.find<ProfileViewModel>()
                                            .userModel,
                                        myFriendUser:
                                            controller.userModel[index],
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: pic == 'default'
                                        ? AssetImage('assets/images/avatar.png')
                                        : pic == ''
                                            ? AssetImage(
                                                'assets/images/avatar.png')
                                            : NetworkImage(pic)
                                                as ImageProvider,
                                  ),
                                  title: Text(name),
                                ),
                              );
                            }
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
          ),
        ),
      );
}
