import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/locationSelector.dart';

import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/statemanagement/statusInfo/statusInfoController.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/biometrics.dart';
import 'package:map_location_picker/map_location_picker.dart';

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
  UserStateController userInfo = Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('customer')
        .doc(userInfo.user.uid.value);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: BorderRadius.circular(AppSizes.small)),
      width: AppSizes.getWitdth(context) * .92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('customer')
                    .doc(userInfo.user.uid.value)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching data from Firestore'),
                    );
                  }

                  var data = snapshot.data?.data() as Map<String, dynamic>?;
                  if (data == null) {
                    return Center(
                      child: Text('Document does not exist'),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppSizes.extraLarge),
                        child: Image(
                          image: NetworkImage("${data['image']}"),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppSizes.small,
                            ),
                            LocationSelector(),
                            SizedBox(
                              height: AppSizes.small,
                            ),
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(AppSizes.small),
                                decoration: BoxDecoration(
                                    color: AppColors.container,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.extraSmall)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data['lastName']}, ${data['firstName']}',
                                      style: TextStyle(
                                          fontSize: AppSizes.small,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${data['email']}',
                                      style:
                                          TextStyle(fontSize: AppSizes.small),
                                    ),
                                    Text(
                                      '${data['phone']}',
                                      style:
                                          TextStyle(fontSize: AppSizes.small),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: AppSizes.extraSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )),
        ],
      ),
    );
  }
}
