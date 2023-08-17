import 'dart:io';

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/CustomerReviewItem.dart';
import 'package:hive_customer/components/bookService.dart';
import 'package:hive_customer/components/locationSelector.dart';
import 'package:hive_customer/components/offersList.dart';
import 'package:hive_customer/components/reviewItem.dart';
import 'package:hive_customer/components/timeItem.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utilities/colors.dart';

class BusinessInfo extends StatefulWidget {
  static String id = "BusinessInfo";

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  UserStateController userInfo = Get.find<UserStateController>();
  @override
  var data = Get.arguments;

  Widget build(BuildContext context) {
    final CollectionReference baseCollectionReference =
        FirebaseFirestore.instance.collection('business');
    final DocumentReference parentDocumentReference =
        baseCollectionReference.doc(data[1]);

    // Replace 'your_subcollection_name' with the actual name of the subcollection in Firestore
    final CollectionReference subcollectionReference =
        parentDocumentReference.collection('offers');

    return Scaffold(
        bottomSheet: Padding(
          padding: EdgeInsets.all(AppSizes.small),
          child: AppButton(
            "Book a service",
            () {
              Get.bottomSheet(
                  BookService(
                    docID: data[1],
                  ),
                  backgroundColor: AppColors.scaffoldBackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.mediumLarge),
                          topRight: Radius.circular(AppSizes.mediumLarge))));
            },
            width: double.infinity,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Container()
                    ]),
                LocationSelector(),
                SizedBox(
                  height: AppSizes.small,
                ),
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.tweenSmall),
                    child: Image.network(
                      data[0]['profilePicture'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    data[0]['businessName'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    data[0]['description'],
                    style: TextStyle(fontSize: AppSizes.tweenSmall),
                  ),
                ),
                SizedBox(
                  height: AppSizes.small,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppButton(
                      "Message",
                      () async {
                        if (Platform.isAndroid) {
                          //FOR Android
                          var url = 'sms:${data[0]["phone"]} ?body=';
                          await launchUrl(Uri.parse(url));
                          FirebaseManager().logAction(
                              "Opened business sms number",
                              userInfo.user.uid.value);
                        } else if (Platform.isIOS) {
                          //FOR IOS
                          var url = 'sms:${data[0]["phone"]}&body=';
                        }
                      },
                      width: AppSizes.extraLarge,
                    ),
                    AppButton(
                      "Call",
                      () async {
                        if (Platform.isAndroid) {
                          //FOR Android
                          var url = 'tel:${data[0]["phone"]} ';
                          await launchUrl(Uri.parse(url));
                          FirebaseManager().logAction(
                              "Opened business phone number",
                              userInfo.user.uid.value);
                        } else if (Platform.isIOS) {
                          //FOR IOS
                          var url = 'tel:${data[0]["phone"]}]';
                        }
                      },
                      width: AppSizes.extraLarge * 0.7,
                    ),
                    AppButton("Email", () async {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: data[0]['businessEmail'],
                      );
                      if (Platform.isAndroid) {
                        //FOR Android
                        var url = emailLaunchUri.toString();
                        await launchUrl(Uri.parse(url));
                        FirebaseManager().logAction(
                            "Opened business email number",
                            userInfo.user.uid.value);
                      } else if (Platform.isIOS) {
                        //FOR IOS
                        var url = emailLaunchUri.toString();
                      }
                    })
                  ],
                ),
                SizedBox(
                  height: AppSizes.small,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Method",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.small),
                          ),
                          Text(
                            "Cash after the job",
                          ),
                          SizedBox(
                            height: AppSizes.small,
                          ),
                          Text(
                            "Service Offered",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.small),
                          ),
                          OfferList(
                            docID: data[1],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available hours",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.small),
                          ),
                          SizedBox(
                            height: AppSizes.tweenSmall,
                          ),
                          TimeItem(
                            start: data[0]['mondayStart'],
                            end: data[0]['mondayEnd'],
                            day: 'Monday',
                          ),
                          TimeItem(
                            start: data[0]['tuesdayStart'],
                            end: data[0]['tuesdayEnd'],
                            day: 'Tuesday',
                          ),
                          TimeItem(
                            start: data[0]['wednesdayStart'],
                            end: data[0]['wednesdayEnd'],
                            day: 'Wednesday',
                          ),
                          TimeItem(
                            start: data[0]['thursdayStart'],
                            end: data[0]['thursdayEnd'],
                            day: 'Thursday',
                          ),
                          TimeItem(
                            start: data[0]['fridayStart'],
                            end: data[0]['fridayEnd'],
                            day: 'Friday',
                          ),
                          TimeItem(
                            start: data[0]['saturdayStart'],
                            end: data[0]['saturdayEnd'],
                            day: 'Saturday',
                          ),
                          TimeItem(
                            start: data[0]['sundayStart'],
                            end: data[0]['sundayEnd'],
                            day: 'Sunday',
                          ),
                        ],
                      ),
                    ]),
                Padding(
                    padding: EdgeInsets.all(AppSizes.small),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reviews",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.medium),
                        ),
                        SizedBox(
                          height: AppSizes.small,
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('reviews')
                              .where("businessID", isEqualTo: data[1])
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
                                      maxHeight:
                                          AppSizes.getHeight(context) * 0.8,
                                      maxWidth:
                                          AppSizes.getWitdth(context) * 0.9),
                                  child: ListView.separated(
                                    itemCount: documents.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: AppSizes.small),
                                    itemBuilder: (context, index) {
                                      var docdata = documents[index].data();
                                      return CustomerReviewItem(
                                        businessID: docdata['businessID'],
                                        customerID: docdata['customerID'],
                                        starRating: docdata['starRating'],
                                        content: docdata['content'],
                                        date: DateFormat('MMMM-dd-yyyy')
                                            .format(docdata['date'].toDate())
                                            .toString(),
                                      );
                                    },
                                  ));
                            } catch (e) {
                              print('Error in StreamBuilder: $e');
                            }
                            return Text('Error');
                          },
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
