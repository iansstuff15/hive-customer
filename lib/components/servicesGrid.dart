import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_customer/components/service.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class ServicesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style:
              TextStyle(fontWeight: FontWeight.w700, fontSize: AppSizes.small),
        ),
        SizedBox(
          height: AppSizes.small,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Service("Send", Icons.send),
            Service("Receive", Icons.attach_money),
            Service("Pay Bills", Icons.receipt_long)
          ],
        ),
        SizedBox(
          height: AppSizes.extraSmall,
        ),
      ],
    );
  }
}
