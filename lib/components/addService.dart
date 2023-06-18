import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/sizes.dart';

class AddService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.medium),
                topRight: Radius.circular(AppSizes.medium))),
        width: double.infinity,
        child: Column(
          children: [Text("Add Data")],
        ));
  }
}
