// ignore_for_file: unnecessary_null_comparison, body_might_complete_normally_nullable

import 'dart:convert';

import 'package:cheeta/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constance.dart';

class LocalStorageData extends GetxController {
  Future<UserModel?> get getUser async {
    try {
      UserModel userModel = await _getUserData();
      if (userModel == null) {
        return null;
      }
      return userModel;
    } catch (e) {
      print(e);
    }
  }

  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var value = prefs.getString(CACHED_USER_DATA);
    return UserModel.fromJson(json.decode(value!));
  }

  setUser(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(CACHED_USER_DATA, json.encode(userModel.toJson()));
  }

  void deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
