import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hive_customer/screens/transactionPage.dart';
import 'package:hive_customer/utilities/sizes.dart';

class TransactionListItem extends StatefulWidget {
  String? date;
  String? transactionID;
  String? status;
  double? price;
  String? time;
  String? businessID;
  String? customerID;
  double? totalPrice;
  List<dynamic>? orders;
  TransactionListItem(
      {required this.date,
      required this.price,
      required this.status,
      required this.transactionID,
      required this.time,
      required this.orders,
      required this.businessID,
      required this.customerID,
      required this.totalPrice});
  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  @override
  Widget build(BuildContext context) {
    return Ink(
        child: InkWell(
            onTap: () {
              Get.toNamed(TransactionPage.id, arguments: [
                widget.transactionID,
                widget.date,
                widget.status,
                widget.price,
                widget.orders,
                widget.time,
                widget.businessID,
                widget.customerID,
                widget.totalPrice,
              ]);
            },
            child: Container(
              width: AppSizes.getWitdth(context) * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.date!,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: widget.status == 'Completed'
                                ? Color.fromARGB(255, 179, 247, 182)
                                : widget.status == 'Pending'
                                    ? Color.fromARGB(255, 233, 150, 101)
                                    : Color.fromARGB(255, 245, 103, 98),
                            borderRadius:
                                BorderRadius.circular(AppSizes.extraLarge)),
                        padding: EdgeInsets.symmetric(
                            vertical: AppSizes.extraSmall,
                            horizontal: AppSizes.tweenSmall),
                        child: Text(
                          "Status: ${widget.status}",
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
                        widget.transactionID!,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "₱ ${widget.price.toString()}",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Divider()
                ],
              ),
            )));
  }
}
