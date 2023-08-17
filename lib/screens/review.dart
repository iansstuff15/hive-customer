import 'package:flutter/material.dart';
import 'package:hive_customer/components/reviewService.dart';
import 'package:get/get.dart';
import 'package:hive_customer/utilities/sizes.dart';

class ReviewPage extends StatelessWidget {
  static String id = 'Review';
  var data = Get.arguments();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          ReviewService(docID: data[0])
        ],
      ),
    );
  }
}
