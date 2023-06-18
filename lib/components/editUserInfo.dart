import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/utilities/sizes.dart';

class EditUserInfo extends StatelessWidget {
  TextEditingController businessName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.medium, horizontal: AppSizes.mediumLarge),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Account Information",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: AppSizes.mediumSmall),
            ),
          ],
        ),
      ),
    );
  }
}
