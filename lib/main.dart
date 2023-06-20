import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:hive_customer/screens/appPages.dart';
import 'package:hive_customer/screens/editBusinessHours.dart';
import 'package:hive_customer/screens/forgotPassword.dart';
import 'package:hive_customer/screens/home.dart';
import 'package:hive_customer/screens/login.dart';
import 'package:hive_customer/screens/profile.dart';
import 'package:hive_customer/screens/register.dart';

import 'package:hive_customer/screens/register.dart';
import 'package:hive_customer/screens/transactionPage.dart';
import 'package:hive_customer/screens/transactions.dart';
import 'package:hive_customer/screens/updateContactInfo.dart';
import 'package:hive_customer/screens/updateFeaturedImages.dart';
import 'package:hive_customer/screens/updateItemPage.dart';
import 'package:hive_customer/screens/welcome.dart';
import 'package:hive_customer/utilities/themeData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hive Business',
      theme: AppCommonData.appTheme,
      routes: {
        Welcome.id: (context) => Welcome(),
        Login.id: (context) => Login(),
        ForgotPassword.id: (context) => ForgotPassword(),
        Register.id: (context) => Register(),
        Home.id: (context) => Home(),
        Profile.id: (context) => Profile(),
        AppPages.id: (context) => AppPages(),
        Transactions.id: (context) => Transactions(),
        TransactionPage.id: (context) => TransactionPage(),
        UpdatePage.id: (context) => UpdatePage(),
        EditBusinessHours.id: (context) => EditBusinessHours(),
        UpdateContactPage.id: (context) => UpdateContactPage(),
        UpdateFeaturedImagePage.id: (context) => UpdateFeaturedImagePage(),
      },
      initialRoute: Login.id,
    );
  }
}
