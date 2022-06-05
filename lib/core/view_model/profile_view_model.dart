// ignore_for_file: unused_field

import 'dart:developer';

import 'package:cheeta/core/services/home_services.dart';
import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/model/category_model.dart';
import 'package:cheeta/model/product_model.dart';
import 'package:cheeta/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';
import '../../view/add_product_view.dart';
import '../../view/home/home_view.dart';
import '../../view/profile_view.dart';

class ProfileViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  final LocalStorageData localStorageData = Get.find();

  UserModel _userModel = new UserModel();
  UserModel get userModel => _userModel;

  void getCurrentUser() async {
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    update();
  }

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    localStorageData.deleteUser();
  }
}
