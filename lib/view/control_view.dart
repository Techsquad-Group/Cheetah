import 'package:cheeta/core/view_model/auth_view_model.dart';
import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user != null)
          ? HomeView()
          : LoginView();
    });
  }
}
