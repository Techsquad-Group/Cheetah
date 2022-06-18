// ignore_for_file: unnecessary_overrides, override_on_non_overriding_member, unused_field, prefer_final_fields, unused_local_variable, avoid_print

import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/model/user_model.dart';
import 'package:cheeta/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cheeta/view/auth/login_view.dart';

import '../../view/control_view.dart';
import '../services/firestore_user.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleLogin = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String email, password, name;

  Rxn<User> _user = Rxn<User>();
  String? get user => _user.value?.email;

  final LocalStorageData localStorageData = Get.find();

  @override
  void onInt() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      getCurrentUserData(_auth.currentUser!.uid);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void googleLoginMethod() async {
    final GoogleSignInAccount? googleUser = await _googleLogin.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    await _auth.signInWithCredential(credential).then((user) async {
      saveUser(user);
      onInt();
      Get.offAll(() => ControlView());
    });
  }

  void signInWithEmailAndPassword() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        getCurrentUserData(value.user!.uid);
      });
      onInt();
      Get.offAll(() => ControlView());
    } catch (e) {
      print(e);

      Get.snackbar("Invalid email or password", "",
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void registerWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        saveUser(user);
      });

      Get.offAll(() => LoginView());
    } catch (e) {
      print(e);

      Get.snackbar("Invalid email or password", e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
      userId: user.user!.uid,
      email: user.user!.email,
      name: user.user!.displayName == null ? name : user.user!.displayName,
      pic: user.user!.photoURL,
      number: user.user!.phoneNumber,
    );
    await FireStoreUser().addUserToFireStore(userModel);
    setUser(userModel);
  }

  void getCurrentUserData(String uid) async {
    await FireStoreUser().getCurrentUser(uid).then((value) {
      setUser(UserModel.fromJson(value.data() as Map<String, dynamic>));
    });
  }

  void setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
  }

  void resetPasswordUsingEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.offAll(() => ControlView());
    } catch (e) {
      print(e);

      Get.snackbar("Invalid email", "",
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
