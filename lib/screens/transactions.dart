import 'dart:developer';

import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppLayout.dart';
import 'package:hive_customer/components/transactionListItem.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class Transactions extends StatefulWidget {
  static String id = 'transactions';

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<String> tags = [];
  UserStateController userInfo = Get.find<UserStateController>();
  TextEditingController searchText = TextEditingController();

  List<String> options = [
    'Completed',
    'Pending',
    'Cancelled',
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mediumSmall, vertical: AppSizes.small),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Transactions',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: AppSizes.extraSmall),
              SizedBox(
                width: AppSizes.getWitdth(context) * 0.9,
                child: AppInput("Search price, transaction ID, or date booked",
                    TextInputType.text, searchText),
              ),

              // ChipsChoice<String>.multiple(
              //   value: tags,
              //   onChanged: (val) {
              //     print(val.toString());
              //     setState(() => tags = val);
              //   },
              //   choiceStyle: C2ChipStyle.filled(
              //     selectedStyle: C2ChipStyle(
              //       backgroundColor: AppColors.textBox,
              //     ),
              //   ),
              //   choiceItems: C2Choice.listFrom<String, String>(
              //     source: options,
              //     value: (i, v) => v,
              //     label: (i, v) => v,
              //   ),
              // ),

              Obx(() => StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('orders')
                        .where(
                          "customerID",
                          isEqualTo: userInfo.user.uid.value,
                        )
                        .snapshots(),
                    builder: (context, snapshot) {
                      try {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // If there's data available, display it in a ListView
                        var documents = snapshot.data!.docs;
                        return ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: AppSizes.getHeight(context) * 0.8,
                                maxWidth: AppSizes.getWitdth(context) * 0.9),
                            child: ListView.separated(
                              itemCount: documents.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: AppSizes.small),
                              itemBuilder: (context, index) {
                                var docdata = documents[index].data();
                                return (tags.contains(docdata['status']) ||
                                                tags.isEmpty) &&
                                            (docdata['totalPrice']
                                                    .toString()
                                                    .contains(
                                                        searchText.text) ||
                                                docdata['uid']
                                                    .toString()
                                                    .contains(
                                                        searchText.text)) ||
                                        docdata['dateBooked']
                                            .toString()
                                            .contains(searchText.text)
                                    ? TransactionListItem(
                                        date: docdata['dateBooked'],
                                        price: docdata['totalPrice'],
                                        status: docdata['status'],
                                        transactionID: docdata['uid'],
                                        orders:
                                            docdata['order'] as List<dynamic>,
                                        time: docdata['timeBooked'],
                                        customerID: docdata['customerID'],
                                        businessID: docdata['businessID'],
                                        totalPrice: docdata['totalPrice'],
                                      )
                                    : Container();
                              },
                            ));
                      } catch (e) {
                        print('Error in StreamBuilder: $e');
                      }
                      return Text('Error');
                    },
                  )),

              // Add other sliver widgets here, such as SliverList or SliverGrid
            ],
          ))),
    );
  }
}
