import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_customer/components/transactionListItem.dart';

import '../utilities/sizes.dart';

class TransactionGrid extends StatelessWidget {
  const TransactionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Orders',
          style:
              TextStyle(fontWeight: FontWeight.w700, fontSize: AppSizes.small),
        ),
        SizedBox(
          height: AppSizes.small,
        ),
        Container(
          width: AppSizes.getWitdth(context),
          height: 150,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(
              height: AppSizes.small,
            ),
            itemBuilder: (BuildContext context, int index) {
              return TransactionListItem();
            },
          ),
        ),
      ],
    );
  }
}
