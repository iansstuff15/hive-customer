import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/statemanagement/statusInfo/statusInfoController.dart';
import 'package:hive_customer/utilities/biometrics.dart';

import '../statemanagement/businessInfo/businessInfoController.dart';
import 'AppButton.dart';
import '../utilities/colors.dart';
import '../utilities/sizes.dart';

class AppCard extends StatefulWidget {
  bool hideInformation = false;
  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  BusinessInfoController _businessInfoController =
      Get.find<BusinessInfoController>();
  StatusInfoController _statusInfoController = Get.find<StatusInfoController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: BorderRadius.circular(AppSizes.small)),
      width: AppSizes.getWitdth(context) * .92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.extraLarge),
                child: Obx(() => Image(
                      image: NetworkImage(_businessInfoController
                          .businessInfo.profilePicFile
                          .toString()),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSizes.extraSmall,
                ),
                Obx(() => Text(
                      _businessInfoController.businessInfo.businessName
                          .toString(),
                      style: TextStyle(
                          fontSize: AppSizes.small,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                    )),
                SizedBox(
                  height: AppSizes.extraSmall,
                ),
                Obx(() => Text(
                      _businessInfoController.businessInfo.businessType
                          .toString(),
                      style: TextStyle(
                        fontSize: AppSizes.small,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(
                  height: AppSizes.extraSmall,
                ),
                Obx(() => Text(
                      _businessInfoController.businessInfo.description
                          .toString(),
                      style: TextStyle(fontSize: AppSizes.tweenSmall),
                    )),
                SizedBox(
                  height: AppSizes.extraSmall,
                ),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppSizes.small),
                    decoration: BoxDecoration(
                        color: AppColors.container,
                        borderRadius:
                            BorderRadius.circular(AppSizes.extraSmall)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Earning',
                          style: TextStyle(
                              fontSize: AppSizes.small,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₱ 9000',
                          style: TextStyle(fontSize: AppSizes.small),
                        ),
                      ],
                    )),
                SizedBox(
                  height: AppSizes.extraSmall,
                ),
                Obx(() => AppButton(
                      _statusInfoController.statusInfo.isOnline.value
                          ? "Go Offline"
                          : "Go Online",
                      () {
                        if (_statusInfoController.statusInfo.isOnline.value) {
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User? user) {
                            if (user != null) {}
                          });
                        } else {
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User? user) {
                            if (user != null) {}
                          });
                        }
                      },
                      width: double.infinity,
                      background:
                          _statusInfoController.statusInfo.isOnline.value
                              ? AppColors.textBox
                              : AppColors.primary,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
