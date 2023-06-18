import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/screens/login.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/sizes.dart';

class DeleteConfirm extends StatefulWidget {
  String? uid;

  DeleteConfirm(this.uid);
  @override
  State<DeleteConfirm> createState() => _DeleteConfirmState();
}

class _DeleteConfirmState extends State<DeleteConfirm> {
  UserStateController _userStateController = Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppSizes.medium, horizontal: AppSizes.mediumLarge),
        child: Column(
          children: [
            Text(
              'Are you sure you want to delete this item?',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: AppSizes.mediumSmall),
              textAlign: TextAlign.center,
            ),
            Image(
              image: AssetImage('assets/delete.png'),
              height: AppSizes.getHeight(context) * .3,
            ),
            AppButton(
              "Continue Delete",
              () {
                FirebaseManager()
                    .db
                    .collection('business')
                    .doc(_userStateController.user.uid.value)
                    .collection('offers')
                    .doc(widget.uid)
                    .delete();
                Get.back();
              },
              width: double.infinity,
            ),
            SizedBox(
              height: AppSizes.extraSmall,
            ),
            AppTextButton(
              "Cancel",
              () {
                Get.back();
              },
              width: double.infinity,
            )
          ],
        ));
  }
}
