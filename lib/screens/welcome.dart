// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/screens/login.dart';
import 'package:hive_customer/utilities/sizes.dart';

class Welcome extends StatelessWidget {
  static String id = "welcome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mediumSmall, vertical: AppSizes.small),
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: AppSizes.small, sigmaY: AppSizes.small),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Manage your finances with ease and security",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.mediumLarge),
                        ),
                        SizedBox(
                          height: AppSizes.medium,
                        ),
                        AppButton(
                          "Get Started",
                          () => {Get.toNamed(Login.id)},
                          width: double.infinity,
                          height: AppSizes.large,
                          textSize: AppSizes.small,
                          textWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  )))),
    );
  }
}
