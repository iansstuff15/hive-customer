import 'dart:async';
import 'dart:developer';

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/CustomerReviewItem.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Offer {
  final int id;
  final String name;
  final double price;

  Offer({
    required this.id,
    required this.name,
    required this.price,
  });
}

class ReviewController extends GetxController {
  // Declare your variables here
  final TextEditingController textEditingController = TextEditingController();
}

class ReviewService extends StatefulWidget {
  String? docID;
  String? transactionID;
  ReviewService({this.docID, this.transactionID});

  @override
  State<ReviewService> createState() => _ReviewServiceState();
}

class _ReviewServiceState extends State<ReviewService> {
  TextEditingController review = TextEditingController();
  UserStateController userInfo = Get.find<UserStateController>();
  final ReviewController content = Get.put(ReviewController());
  StreamSubscription<DocumentSnapshot>? documentStreamSubscription;
  Map<String, dynamic>? docdata;
  double starValue = 0.0;
  @override
  void initState() {
    super.initState();
    print("id");
    // Subscribe to the Firestore document changes
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.transactionID)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        // Handle the document data here
        Map<String, dynamic> documentData =
            snapshot.data() as Map<String, dynamic>;
        // Update your UI or perform any other actions based on the changes in the documentData
        print('Document data: $documentData');
        setState(() {
          docdata = documentData;
        });
      } else {
        // Handle the case when the document does not exist
        print('Document does not exist.');
      }
    });
  }

  @override
  void dispose() {
    // Cancel the stream subscription to avoid memory leaks
    documentStreamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.getHeight(context) * 0.02,
              horizontal: AppSizes.small,
            ),
            child: docdata?['reviewExist'] == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(
                          height: AppSizes.mediumSmall,
                        ),
                        Text(
                          "Review service",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.mediumSmall,
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.small,
                        ),
                        RatingStars(
                          value: starValue,
                          onValueChanged: (v) {
                            setState(() {
                              starValue = v;
                            });
                          },
                          starBuilder: (index, color) => Icon(
                            Icons.star,
                            color: color,
                            size: AppSizes.medium,
                          ),
                          starCount: 5,
                          starSize: AppSizes.medium,
                          maxValue: 5,
                          starSpacing: 0,
                          maxValueVisibility: true,
                          valueLabelVisibility: false,
                          animationDuration: Duration(milliseconds: 1000),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: AppColors.primary,
                        ),
                        SizedBox(
                          height: AppSizes.small,
                        ),
                        AppInput(
                          "Tell us what you taught of the service",
                          TextInputType.text,
                          content.textEditingController,
                          maxLines: 10,
                        ),
                        SizedBox(
                          height: AppSizes.small,
                        ),
                        SizedBox(
                          height: AppSizes.small,
                        ),
                        Obx(() => AppButton(
                              "Review from ${userInfo.user.email}",
                              () {
                                CollectionReference orderCollectionRef =
                                    FirebaseFirestore.instance
                                        .collection('reviews');

                                orderCollectionRef
                                    .add({
                                      'customerID': userInfo.user.uid.value,
                                      'businessID': widget.docID,
                                      "content":
                                          content.textEditingController.text,
                                      "starRating": starValue,
                                      "date": Timestamp.now()
                                    })
                                    .then((value) async {
                                      await orderCollectionRef
                                          .doc(value.id)
                                          .update({"uid": value.id});
                                    })
                                    .then((value) => {
                                          FirebaseFirestore.instance
                                              .collection("orders")
                                              .doc(widget.transactionID)
                                              .update({"reviewExist": true})
                                        })
                                    .then((value) => FirebaseManager()
                                        .logAction("Reviewed Order",
                                            userInfo.user.uid.value));
                                Get.back();
                              },
                              width: double.infinity,
                            ))
                      ])
                : Column(
                    children: [Text("Review Already Written")],
                  )));
  }
}
