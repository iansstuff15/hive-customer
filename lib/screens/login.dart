// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';
import 'dart:ui';

import 'package:bottom_loader/bottom_loader.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/screens/appPages.dart';
import 'package:hive_customer/screens/forgotPassword.dart';
import 'package:hive_customer/screens/home.dart';
import 'package:hive_customer/screens/register.dart';
import 'package:hive_customer/screens/register.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

import '../main.dart';
import '../statemanagement/businessInfo/businessInfoController.dart';

class Login extends StatelessWidget {
  final UserStateController _userStateController =
      Get.put(UserStateController());
  final BusinessInfoController businessInfoController =
      BusinessInfoController();
  static String id = "login";
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BottomLoader bl = BottomLoader(context,
        isDismissible: false,
        showLogs: false,
        loader: CircularProgressIndicator(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.small),
                topRight: Radius.circular(AppSizes.small))));
    return Scaffold(
      body: SafeArea(
          child: Container(
              child: Stack(children: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.all(AppSizes.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ))),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: AppSizes.getHeight(context) * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSizes.small),
                        topRight: Radius.circular(AppSizes.small))),
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.mediumSmall,
                    vertical: AppSizes.extraSmall),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.mediumLarge),
                      ),
                      SizedBox(
                        height: AppSizes.small,
                      ),
                      AppInput(
                          "Email", TextInputType.emailAddress, emailAddress),
                      SizedBox(
                        height: AppSizes.small,
                      ),
                      AppInput(
                        "Password",
                        TextInputType.text,
                        password,
                        obsure: true,
                      ),
                      SizedBox(
                        height: AppSizes.extraSmall,
                      ),
                      AppTextButton(
                        "Forgot Password",
                        () => {Get.toNamed(ForgotPassword.id)},
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: AppSizes.extraSmall,
                      ),
                      AppButton(
                        "Login",
                        () async {
                          await bl.display();
                          String response = await FirebaseManager()
                              .login(emailAddress.text, password.text);

                          ElegantNotification(
                                  icon: response == "success"
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.error_rounded,
                                          color: Colors.redAccent,
                                        ),
                                  showProgressIndicator: false,
                                  displayCloseButton: false,
                                  title: Text(response == "success"
                                      ? "Sucess"
                                      : "Error"),
                                  description: Text(response == 'success'
                                      ? "Welcome ${_userStateController.user.email}"
                                      : response))
                              .show(context);
                          bl.close();
                          if (response == 'success') {}
                        },
                        width: double.infinity,
                        height: AppSizes.mediumLarge,
                        textSize: AppSizes.small,
                        textWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: AppSizes.small,
                      ),
                      // AppButton(
                      //   "Sign in with Google",
                      //   () => {},
                      //   width: double.infinity,
                      //   height: AppSizes.mediumLarge,
                      //   textSize: AppSizes.small,
                      //   textWeight: FontWeight.bold,
                      //   background: Colors.white,
                      //   foreground: Colors.black,
                      //   icon: 'assets/google.svg',
                      // ),
                      // SizedBox(
                      //   height: AppSizes.small,
                      // ),
                      AppTextButton(
                        "Dont have an account yet? Sign up",
                        () => {Get.toNamed(Register.id)},
                        width: double.infinity,
                      ),
                    ],
                  ),
                )))
      ]))),
    );
  }
}
