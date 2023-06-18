import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hive_customer/screens/transactionPage.dart';
import 'package:hive_customer/utilities/sizes.dart';

class TransactionListItem extends StatefulWidget {
  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  @override
  Widget build(BuildContext context) {
    return Ink(
        child: InkWell(
            onTap: () {
              Get.toNamed(TransactionPage.id);
            },
            child: Container(
              width: AppSizes.getWitdth(context) * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "March 24, 2023",
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 179, 247, 182),
                            borderRadius:
                                BorderRadius.circular(AppSizes.extraLarge)),
                        padding: EdgeInsets.symmetric(
                            vertical: AppSizes.extraSmall,
                            horizontal: AppSizes.tweenSmall),
                        child: Text(
                          "Status: Completed",
                          style: TextStyle(
                              fontSize: AppSizes.extraSmall,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.extraSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "123 456 789 000",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "₱ 100.00",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
