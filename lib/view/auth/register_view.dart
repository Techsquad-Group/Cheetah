// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:cheeta/core/view_model/auth_view_model.dart';
import 'package:cheeta/view/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constance.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/custom_buttom_social.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterView extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.off(() => LoginView());
              },
              child: Icon(Icons.arrow_back, color: primaryColor)),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
          ),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Register, ",
                      fontSize: 30,
                      color: primaryColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  text: "Name",
                  hintText: "Alex",
                  onSave: (value) {
                    controller.name = value!;
                  },
                  validator: 'Please enter your name',
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  text: "Email",
                  hintText: "xyz@gmail.com",
                  onSave: (value) {
                    controller.email = value!;
                  },
                  validator: 'Please enter your email',
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
                  validator: 'Please enter your password',
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  onPress: () {
                    _formKey.currentState?.save();
                    if (_formKey.currentState!.validate()) {
                      controller.registerWithEmailAndPassword();
                    }
                  },
                  text: "Register",
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => LoginView());
                    },
                    child: CustomText(
                      text: "Have an account? login here",
                      fontSize: 12,
                      color: Colors.grey.shade800,
                      alignment: Alignment.center,
                    )),
              ])),
        ));
  }
}
