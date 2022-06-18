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
import '../../view/home_view.dart';
import '../../view/profile_view.dart';

class ProfileViewModel extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  final LocalStorageData localStorageData = Get.find();

  UserModel _userModel = new UserModel();
  UserModel get userModel => _userModel;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  void getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    _loading.value = false;
    update();
  }

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    localStorageData.deleteUser();
  }
}
