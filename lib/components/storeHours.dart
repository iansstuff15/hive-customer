import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/components/editUserInfo.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/screens/editBusinessHours.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

import '../statemanagement/businessInfo/businessInfoController.dart';

class StoreHours extends StatefulWidget {
  @override
  State<StoreHours> createState() => _StoreHoursState();
}

class _StoreHoursState extends State<StoreHours> {
  final TextStyle style = TextStyle(fontSize: AppSizes.tweenSmall);

  final TextStyle styleDay =
      TextStyle(fontSize: AppSizes.tweenSmall, fontWeight: FontWeight.bold);

  BusinessInfoController _businessInfoController =
      Get.find<BusinessInfoController>();

  UserStateController _userStateController = Get.find<UserStateController>();

  getBusinessInfo() {}

  String? mondayStart = '';
  String? tuesdayStart = '';
  String? wednesdayStart = '';
  String? thursdayStart = '';
  String? fridayStart = '';
  String? saturdayStart = '';
  String? sundayStart = '';

  String? mondayEnd = '';
  String? tuesdayEnd = '';
  String? wednesdayEnd = '';
  String? thursdayEnd = '';
  String? fridayEnd = '';
  String? saturdayEnd = '';
  String? sundayEnd = '';
  CollectionReference docRef = FirebaseManager().db.collection('business');
  TimeOfDay now = TimeOfDay.now();
  Future<String> showTimeSelector() async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: now,
    );
    log(picked_s!.format(context).toString());
    return picked_s!.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Business Hours",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: AppSizes.mediumSmall),
                ),
                AppTextButton(
                  "Edit Account",
                  () {
                    Get.toNamed(EditBusinessHours.id);
                  },
                ),
              ],
            ),
            Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  // textDirection: TextDirection.rtl,
                  // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  // border:TableBorder.all(width: 2.0,color: Colors.red),
                  children: [
                    TableRow(children: [
                      Text(
                        "Monday",
                        style: styleDay,
                      ),
                      Obx(() => Text(
                            "${_businessInfoController.businessInfo.mondayStart} to ${_businessInfoController.businessInfo.mondayEnd}",
                            style: style,
                          )),
                    ]),
                    TableRow(children: [
                      Text(
                        "Tuesday",
                        style: styleDay,
                      ),
                      Obx(() => Text(
                            "${_businessInfoController.businessInfo.tuesdayStart} to ${_businessInfoController.businessInfo.tuesdayEnd}",
                            style: style,
                          )),
                    ]),
                    TableRow(children: [
                      Text(
                        "Wednesday",
                        style: styleDay,
                      ),
                      Obx(() => Text(
                            "${_businessInfoController.businessInfo.wednesdayStart} to ${_businessInfoController.businessInfo.wednesdayEnd}",
                            style: style,
                          )),
                    ]),
                    TableRow(children: [
                      Text(
                        "Thursday",
                        style: styleDay,
                      ),
                      Obx(
                        () => Text(
                          "${_businessInfoController.businessInfo.thursdayStart} to ${_businessInfoController.businessInfo.thursdayEnd}",
                          style: style,
                        ),
                      )
                    ]),
                    TableRow(children: [
                      Text(
                        "Friday",
                        style: styleDay,
                      ),
                      Obx(() => Text(
                            "${_businessInfoController.businessInfo.fridayStart} to ${_businessInfoController.businessInfo.fridayEnd}",
                            style: style,
                          )),
                    ]),
                    TableRow(children: [
                      Text(
                        "Saturday",
                        style: styleDay,
                      ),
                      Text(
                        "${_businessInfoController.businessInfo.saturdayStart} to ${_businessInfoController.businessInfo.saturdayEnd}",
                        style: style,
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        "Sunday",
                        style: styleDay,
                      ),
                      Text(
                        "${_businessInfoController.businessInfo.sundayStart} to ${_businessInfoController.businessInfo.sundayEnd}",
                        style: style,
                      ),
                    ]),
                  ],
                ),
              ),
            ])
          ],
        ));
  }
}
