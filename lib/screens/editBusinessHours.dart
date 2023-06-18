import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/screens/profile.dart';
import 'package:hive_customer/statemanagement/businessInfo/businessInfoController.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class EditBusinessHours extends StatefulWidget {
  static String id = 'EditBusinessHours';
  @override
  State<EditBusinessHours> createState() => _EditBusinessHoursState();
}

class _EditBusinessHoursState extends State<EditBusinessHours> {
  final TextStyle style = TextStyle(fontSize: AppSizes.tweenSmall);

  final TextStyle styleDay = TextStyle(
      fontSize: AppSizes.tweenSmall,
      fontWeight: FontWeight.bold,
      color: AppColors.textBox);

  BusinessInfoController _businessInfoController =
      Get.find<BusinessInfoController>();

  UserStateController _userStateController = Get.find<UserStateController>();

  String? mondayStart = 'Start';
  String? tuesdayStart = 'Start';
  String? wednesdayStart = 'Start';
  String? thursdayStart = 'Start';
  String? fridayStart = 'Start';
  String? saturdayStart = 'Start';
  String? sundayStart = 'Start';

  String? mondayEnd = 'End';
  String? tuesdayEnd = 'End';
  String? wednesdayEnd = 'End';
  String? thursdayEnd = 'End';
  String? fridayEnd = 'End';
  String? saturdayEnd = 'End';
  String? sundayEnd = 'End';

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

  TextEditingController businessName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.medium, vertical: AppSizes.extraSmall),
        child: AppButton(
          'Save',
          () async {
            final updateData = Map<String, dynamic>();

            if (mondayStart != "Start") {
              updateData['mondayStart'] = mondayStart!;
            }
            if (mondayEnd != "End") {
              updateData['mondayEnd'] = mondayEnd!;
            }
            if (tuesdayStart != "Start") {
              updateData['tuesdayStart'] = tuesdayStart!;
            }
            if (tuesdayEnd != "End") {
              updateData['tuesdayEnd'] = tuesdayEnd!;
            }
            if (wednesdayStart != "Start") {
              updateData['wednesdayStart'] = wednesdayStart!;
            }
            if (wednesdayEnd != "End") {
              updateData['wednesdayEnd'] = wednesdayEnd!;
            }
            if (thursdayStart != "Start") {
              updateData['thursdayStart'] = thursdayStart!;
            }
            if (thursdayEnd != "End") {
              updateData['thursdayEnd'] = thursdayEnd!;
            }
            if (fridayStart != "Start") {
              updateData['fridayStart'] = fridayStart!;
            }
            if (fridayEnd != "End") {
              updateData['fridayEnd'] = fridayEnd!;
            }
            if (saturdayStart != "Start") {
              updateData['saturdayStart'] = saturdayStart!;
            }
            if (saturdayEnd != "End") {
              updateData['saturdayEnd'] = saturdayEnd!;
            }
            if (sundayStart != "Start") {
              updateData['sundayStart'] = sundayStart!;
            }
            if (sundayEnd != "End") {
              updateData['sundayEnd'] = sundayEnd!;
            }

            await docRef
              ..doc(_userStateController.user.uid.value).update(updateData);
            Get.toNamed(Profile.id);
          },
          width: double.infinity,
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(AppSizes.mediumSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: AppSizes.medium,
                  ),
                ),
                Align(
                  child: Text(
                    'Update Operating Hours',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: AppSizes.medium),
                    textAlign: TextAlign.center,
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSizes.small)),
                  padding: EdgeInsets.all(AppSizes.small),
                  height: AppSizes.getHeight(context) * 0.2,
                  child: Column(children: [
                    Text(
                      'Current Information',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.small,
                          color: AppColors.textBox),
                    ),
                    Table(
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
                    )
                  ]),
                ),
                SizedBox(
                    height: AppSizes.getHeight(context) * 0.35,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        SizedBox(
                          height: AppSizes.medium,
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                              child: Column(children: [
                            Text(
                              "Monday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.small),
                            ),
                            SizedBox(
                              height: AppSizes.tweenSmall,
                            ),
                            Row(
                              children: [
                                AppTextButton(mondayStart, () async {
                                  String response = await showTimeSelector();

                                  setState(() {
                                    mondayStart = response;
                                  });
                                },
                                    background: AppColors.container,
                                    width: AppSizes.getWitdth(context) * 0.4),
                                SizedBox(
                                  width: AppSizes.small,
                                ),
                                AppTextButton(
                                  mondayEnd,
                                  () async {
                                    String response = await showTimeSelector();

                                    setState(() {
                                      mondayEnd = response;
                                    });
                                  },
                                  background: AppColors.container,
                                  width: AppSizes.getWitdth(context) * 0.4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.small,
                            ),
                            Text(
                              "Tuesday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.small),
                            ),
                            SizedBox(
                              height: AppSizes.tweenSmall,
                            ),
                            Row(
                              children: [
                                AppTextButton(tuesdayStart, () async {
                                  String response = await showTimeSelector();

                                  setState(() {
                                    tuesdayStart = response;
                                  });
                                },
                                    background: AppColors.container,
                                    width: AppSizes.getWitdth(context) * 0.4),
                                SizedBox(
                                  width: AppSizes.small,
                                ),
                                AppTextButton(
                                  tuesdayEnd,
                                  () async {
                                    String response = await showTimeSelector();

                                    setState(() {
                                      tuesdayEnd = response;
                                    });
                                  },
                                  background: AppColors.container,
                                  width: AppSizes.getWitdth(context) * 0.4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.small,
                            ),
                            Text(
                              "Wednesday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.small),
                            ),
                            SizedBox(
                              height: AppSizes.tweenSmall,
                            ),
                            Row(
                              children: [
                                AppTextButton(wednesdayStart, () async {
                                  String response = await showTimeSelector();

                                  setState(() {
                                    wednesdayStart = response;
                                  });
                                },
                                    background: AppColors.container,
                                    width: AppSizes.getWitdth(context) * 0.4),
                                SizedBox(
                                  width: AppSizes.small,
                                ),
                                AppTextButton(
                                  wednesdayEnd,
                                  () async {
                                    String response = await showTimeSelector();

                                    setState(() {
                                      wednesdayEnd = response;
                                    });
                                  },
                                  background: AppColors.container,
                                  width: AppSizes.getWitdth(context) * 0.4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.small,
                            ),
                            Text(
                              "Thursday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.small),
                            ),
                            SizedBox(
                              height: AppSizes.tweenSmall,
                            ),
                            Row(
                              children: [
                                AppTextButton(thursdayStart, () async {
                                  String response = await showTimeSelector();

                                  setState(() {
                                    thursdayStart = response;
                                  });
                                },
                                    background: AppColors.container,
                                    width: AppSizes.getWitdth(context) * 0.4),
                                SizedBox(
                                  width: AppSizes.small,
                                ),
                                AppTextButton(
                                  thursdayEnd,
                                  () async {
                                    String response = await showTimeSelector();

                                    setState(() {
                                      thursdayEnd = response;
                                    });
                                  },
                                  background: AppColors.container,
                                  width: AppSizes.getWitdth(context) * 0.4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.small,
                            ),
                            Text(
                              "Friday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.small),
                            ),
                            SizedBox(
                              height: AppSizes.tweenSmall,
                            ),
                            Row(
                              children: [
                                AppTextButton(fridayStart, () async {
                                  String response = await showTimeSelector();

                                  setState(() {
                                    fridayStart = response;
                                  });
                                },
                                    background: AppColors.container,
                                    width: AppSizes.getWitdth(context) * 0.4),
                                SizedBox(
                                  width: AppSizes.small,
                                ),
                                AppTextButton(
                                  fridayEnd,
                                  () async {
                                    String response = await showTimeSelector();

                                    setState(() {
                                      fridayEnd = response;
                                    });
                                  },
                                  background: AppColors.container,
                                  width: AppSizes.getWitdth(context) * 0.4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.small,
                            ),
                            Text(
                              "Saturday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.small),
                            ),
                            SizedBox(
                              height: AppSizes.tweenSmall,
                            ),
                            Row(
                              children: [
                                AppTextButton(saturdayStart, () async {
                                  String response = await showTimeSelector();

                                  setState(() {
                                    saturdayStart = response;
                                  });
                                },
                                    background: AppColors.container,
                                    width: AppSizes.getWitdth(context) * 0.4),
                                SizedBox(
                                  width: AppSizes.small,
                                ),
                                AppTextButton(
                                  saturdayEnd,
                                  () async {
                                    String response = await showTimeSelector();

                                    setState(() {
                                      saturdayEnd = response;
                                    });
                                  },
                                  background: AppColors.container,
                                  width: AppSizes.getWitdth(context) * 0.4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.small,
                            ),
                            Text(
                              "Sunday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.small),
                            ),
                            SizedBox(
                              height: AppSizes.tweenSmall,
                            ),
                            Row(
                              children: [
                                AppTextButton(sundayStart, () async {
                                  String response = await showTimeSelector();

                                  setState(() {
                                    sundayStart = response;
                                  });
                                },
                                    background: AppColors.container,
                                    width: AppSizes.getWitdth(context) * 0.4),
                                SizedBox(
                                  width: AppSizes.small,
                                ),
                                AppTextButton(
                                  sundayEnd,
                                  () async {
                                    String response = await showTimeSelector();

                                    setState(() {
                                      sundayEnd = response;
                                    });
                                  },
                                  background: AppColors.container,
                                  width: AppSizes.getWitdth(context) * 0.4,
                                ),
                              ],
                            ),
                          ])),
                        ),
                        SizedBox(
                          height: AppSizes.small,
                        ),
                      ],
                    ))),
              ],
            )),
      ),
    );
  }
}
