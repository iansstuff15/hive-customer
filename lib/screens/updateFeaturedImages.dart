import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/screens/profile.dart';

import 'package:hive_customer/statemanagement/businessInfo/businessInfoController.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class UpdateFeaturedImagePage extends StatelessWidget {
  static String id = 'UpdateFeaturedImagePage';
  TextEditingController emailController = TextEditingController();
  final controller = MultiImagePickerController(
      maxImages: 15,
      allowedImageTypes: ['png', 'jpg', 'jpeg'],
      withData: true,
      withReadStream: true,
      images: <ImageFile>[] // array of pre/default selected images
      );
  TextEditingController phoneController = TextEditingController();
  UserStateController _userStateController = Get.find<UserStateController>();
  CollectionReference docRef = FirebaseManager().db.collection('business');
  BusinessInfoController _businessInfoController =
      Get.find<BusinessInfoController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.extraSmall, horizontal: AppSizes.medium),
          child: AppButton(
            "Save Update",
            () async {
              if (phoneController.text != '') {
                await docRef
                    .doc(_userStateController.user.uid.value)
                    .update({"phone": phoneController.text});
              }
              Get.toNamed(Profile.id);
            },
            width: AppSizes.getWitdth(context) * 0.9,
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
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
                'Update Featured Image',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppSizes.medium),
              ),
              alignment: Alignment.center,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSizes.small)),
              padding: EdgeInsets.all(AppSizes.small),
              width: double.infinity,
              margin: EdgeInsets.all(AppSizes.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Information',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.small,
                        color: AppColors.textBox),
                  ),
                  SizedBox(
                    height: AppSizes.extraSmall,
                  ),
                  Text(
                    "Phone",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.textBox),
                  ),
                  Text(_businessInfoController.businessInfo.phone.value),
                  SizedBox(
                    height: AppSizes.extraSmall,
                  ),
                  SizedBox(
                    height: AppSizes.extraSmall,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.container,
                  borderRadius: BorderRadius.circular(AppSizes.small)),
              padding: EdgeInsets.all(AppSizes.small),
              width: double.infinity,
              margin: EdgeInsets.all(AppSizes.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Update Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.small,
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.extraSmall,
                  ),
                  MultiImagePickerView(
                    controller: controller,
                    padding: const EdgeInsets.all(10),
                  )
                ],
              ),
            ),
          ],
        ))));
  }
}
