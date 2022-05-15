// ignore_for_file: prefer_const_constructors

import 'package:cheeta/constance.dart';
import 'package:cheeta/core/view_model/auth_view_model.dart';
import 'package:cheeta/view/auth/register_view.dart';
import 'package:cheeta/view/widgets/custom_buttom.dart';
import 'package:cheeta/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_buttom_social.dart';
import '../widgets/custom_text_form_field.dart';
import 'register_view.dart';

class LoginView extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
          ),
          child: Form(
              key: _formKey,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Login, ",
                      fontSize: 30,
                      color: primaryColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextFormField(
                  text: "Email",
                  hintText: "xyz@gmail.com",
                  onSave: (value) {
                    controller.email = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  text: "Password",
                  hintText: "********",
                  onSave: (value) {
                    controller.password = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => RegisterView());
                    },
                    child: CustomText(
                      text: "Forgot password?",
                      fontSize: 12,
                      alignment: Alignment.topRight,
                    )),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPress: () {
                    _formKey.currentState?.save();
                    if (_formKey.currentState!.validate()) {
                      controller.signInWithEmailAndPassword();
                    }
                  },
                  text: "LOGIN",
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => RegisterView());
                    },
                    child: CustomText(
                      text: "Dont have an account? register here",
                      fontSize: 12,
                      color: Colors.grey.shade800,
                      alignment: Alignment.center,
                    )),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: "- OR -",
                  fontSize: 14,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButtonSocial(
                  onPress: () {
                    controller.googleLoginMethod();
                  },
                  text: "Login with Google",
                  imgName: "assets/images/google.png",
                ),
              ])),
        ));
  }
}
