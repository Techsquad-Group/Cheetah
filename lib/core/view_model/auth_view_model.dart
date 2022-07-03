// ignore_for_file: unnecessary_overrides, override_on_non_overriding_member, unused_field, prefer_final_fields, unused_local_variable, avoid_print

import 'package:cheeta/core/services/firestore_chat.dart';
import 'package:cheeta/local_storage_data.dart';
import 'package:cheeta/model/chat_model.dart';
import 'package:cheeta/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cheeta/view/auth/login_view.dart';

import '../../view/control_view.dart';
import '../services/firestore_people.dart';
import '../services/firestore_user.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleLogin = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String email, password, name;

  Rxn<User> _user = Rxn<User>();
  String? get user => _user.value?.email;

  List<UserModel> _userModel = [];
  List<UserModel> get userModel => _userModel;

  List<ChatModel> _chatModel = [];
  List<ChatModel> get chatModel => _chatModel;

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
      saveUser(user, 'google');
      onInt();
      Get.offAll(() => ControlView());
    });
  }

  void registerWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        saveUser(user, 'normal');
      });

      Get.offAll(() => LoginView());
    } catch (e) {
      print(e);

      Get.snackbar("Invalid email or password", e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
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

  void saveUser(UserCredential user, String registeredWith) async {
    UserModel userModel = UserModel(
      userId: user.user!.uid,
      email: user.user!.email,
      name: user.user!.displayName == null ? name : user.user!.displayName,
      pic: user.user!.photoURL,
      number: user.user!.phoneNumber,
      registeredWith: registeredWith,
    );
    await FireStoreUser().addUserToFireStore(userModel);

    await FireStorePeople().getPeople().then((value) {
      _userModel.clear();
      for (int i = 0; i < value.length; i++) {
        _userModel
            .add(UserModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }
    });

    await FireStoreChat().getChats().then((value) {
      for (int i = 0; i < value.length; i++) {
        _chatModel
            .add(ChatModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }
    });

    update();
    setUser(userModel);
    print(_userModel.length.toString());
    for (var i = 0; i < _userModel.length; i++) {
      print(i);
      bool isExict = false;
      String theID = '';
      if (_userModel[i].userId != user.user!.uid) {
        List<String> ids = [_userModel[i].userId.toString(), user.user!.uid];
        ids.sort();
        theID = ids[0].substring(0, 10) + ids[1].substring(10);

        for (var j = 0; j < _chatModel.length; j++) {
          if (theID == _chatModel[j].chatID) {
            isExict = true;
          }
        }

        print(isExict);
        if (!isExict) {
          ChatModel chatModel = ChatModel(
            user1: user.user!.uid,
            user2: _userModel[i].userId,
            chatID: theID,
          );
          FireStoreChat().addChatToFireStore(chatModel);
        }
      }
    }

    update();
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
