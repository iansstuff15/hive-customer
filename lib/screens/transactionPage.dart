import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/bookService.dart';
import 'package:hive_customer/components/reviewItem.dart';
import 'package:hive_customer/components/reviewService.dart';
import 'package:hive_customer/screens/reviewScreen.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';

class ReviewController extends GetxController {
  // Declare your variables here
}

class TransactionPage extends StatelessWidget {
  static String id = 'TransactionPage';
  UserStateController userInfo = Get.find<UserStateController>();

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.extraSmall),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: AppSizes.medium,
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.small)),
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              horizontal: AppSizes.small, vertical: AppSizes.extraSmall),
          padding: EdgeInsets.all(AppSizes.extraSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.small),
                decoration: BoxDecoration(
                    color: AppColors.textBox,
                    borderRadius: BorderRadius.circular(AppSizes.extraLarge)),
                child: Icon(
                  data[2] == "Pending"
                      ? Icons.pending
                      : data[2] == "Completed"
                          ? Icons.check_circle
                          : Icons.cancel,
                  color: AppColors.primary,
                  size: AppSizes.medium,
                ),
              ),
              SizedBox(
                height: AppSizes.tweenSmall,
              ),
              Text(
                'Order ${data[2]}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.mediumSmall),
              ),
              Text(
                'Reference: ${data[0]}',
                style: TextStyle(fontSize: AppSizes.small),
              ),
              Text(
                'Php ${(data[8])}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppSizes.medium),
              ),
            ],
          ),
        ),
        data[2] == 'Completed'
            ? ReviewService(
                transactionID: data[0],
                docID: data[6],
              )
            : Container(),
        SizedBox(
          height: AppSizes.small,
        ),
        TicketWidget(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mediumSmall, vertical: AppSizes.small),
          color: AppColors.primary,
          isCornerRounded: true,
          width: AppSizes.getWitdth(context) * 0.9,
          height: AppSizes.getHeight(context) * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.mediumSmall,
                    color: AppColors.textBox),
              ),
              SizedBox(
                height: AppSizes.small,
              ),
              Text(
                'Service Availed',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.small,
                    color: AppColors.textBox),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: AppSizes.getHeight(context) * 0.07),
                child: ListView.separated(
                  itemCount: data[4].length,
                  itemBuilder: (context, index) {
                    var order = data[4];

                    return Text("${data[4][index]['name']}");
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: AppSizes.extraSmall,
                  ),
                ),
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('customer')
                    .doc(data[7])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching data from Firestore'),
                    );
                  }

                  var docdata = snapshot.data?.data() as Map<String, dynamic>?;
                  if (docdata == null) {
                    return Center(
                      child: Text('Document does not exist'),
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.small,
                                    color: AppColors.textBox),
                              ),
                              Text(
                                docdata['email'],
                                style: TextStyle(
                                    fontSize: AppSizes.small,
                                    color: AppColors.textColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Phone',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.small,
                                    color: AppColors.textBox),
                              ),
                              Text(
                                docdata['phone'],
                                style: TextStyle(
                                    fontSize: AppSizes.small,
                                    color: AppColors.textColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.extraSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Method',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.small,
                                    color: AppColors.textBox),
                              ),
                              Text(
                                'Cash',
                                style: TextStyle(
                                    fontSize: AppSizes.small,
                                    color: AppColors.textColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.small,
                                    color: AppColors.textBox),
                              ),
                              SizedBox(
                                width: AppSizes.extraLarge,
                                child: Text(
                                  docdata['address'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: AppSizes.small,
                                      color: AppColors.textColor),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),

              SizedBox(
                height: AppSizes.extraSmall,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('business')
                    .doc(data[6])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching data from Firestore'),
                    );
                  }

                  var docdata = snapshot.data?.data() as Map<String, dynamic>?;
                  if (docdata == null) {
                    return Center(
                      child: Text('Document does not exist'),
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Business Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.small,
                                    color: AppColors.textBox),
                              ),
                              Text(
                                docdata['businessEmail'],
                                style: TextStyle(
                                    fontSize: AppSizes.small,
                                    color: AppColors.textColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Business Phone',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.small,
                                    color: AppColors.textBox),
                              ),
                              Text(
                                docdata['phone'],
                                style: TextStyle(
                                    fontSize: AppSizes.small,
                                    color: AppColors.textColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.extraSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.small,
                                    color: AppColors.textBox),
                              ),
                              Text(
                                docdata['type'],
                                style: TextStyle(
                                    fontSize: AppSizes.small,
                                    color: AppColors.textColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Business Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.small,
                                    color: AppColors.textBox),
                              ),
                              SizedBox(
                                width: AppSizes.extraLarge,
                                child: Text(
                                  docdata['businessName'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: AppSizes.small,
                                      color: AppColors.textColor),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),

              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date Booked',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        data[1],
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Time Booked',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        data[5],
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //       decoration: BoxDecoration(
              //           color: AppColors.textBox,
              //           borderRadius: BorderRadius.circular(AppSizes.small)),
              //       child: BarcodeWidget(
              //         drawText: false,
              //         barcode: Barcode.code128(),
              //         height: AppSizes.getHeight(context) * 0.15,
              //         padding: EdgeInsets.all(AppSizes.small),
              //         data: data[0],
              //       )),
              // )
            ],
          ),
        )
      ],
    ))));
  }
}
