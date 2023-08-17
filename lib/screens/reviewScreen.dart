import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/reviewService.dart';
import 'package:hive_customer/utilities/sizes.dart';

class Review extends StatelessWidget {
  static String id = 'Review';
  var data = Get.arguments();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(AppSizes.small),
        child: Column(
          children: [],
        ),
      )),
    );
  }
}
