import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/screens/login.dart';
import 'package:hive_customer/utilities/sizes.dart';

class LogoutConfirm extends StatefulWidget {
  const LogoutConfirm({super.key});

  @override
  State<LogoutConfirm> createState() => _LogoutConfirmState();
}

class _LogoutConfirmState extends State<LogoutConfirm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppSizes.medium, horizontal: AppSizes.mediumLarge),
        child: Column(
          children: [
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: AppSizes.mediumSmall),
              textAlign: TextAlign.center,
            ),
            Image(
              image: AssetImage('assets/logout.png'),
              height: AppSizes.getHeight(context) * .3,
            ),
            AppButton(
              "Continue Logout",
              () {
                FirebaseAuth.instance.signOut();
                Get.toNamed(Login.id);
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
