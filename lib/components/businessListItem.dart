import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/helper/geolocation.dart';
import 'package:hive_customer/screens/businessInfo.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/sizes.dart';

class BusinessListItem extends StatefulWidget {
  String? businessName;
  String? description;
  String? image;
  String? docID;
  String? typeFilter;
  String? businessNameFilter;
  bool? searchMode;

  BusinessListItem(
      {required this.businessName,
      required this.description,
      required this.image,
      this.docID,
      this.typeFilter,
      this.businessNameFilter,
      this.searchMode = false});
  @override
  State<BusinessListItem> createState() => _BusinessListItemState();
}

class _BusinessListItemState extends State<BusinessListItem> {
  UserStateController userStateController = Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('customer')
              .doc(userStateController.user.uid.value)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data from Firestore '),
              );
            }

            var customerdata = snapshot.data?.data() as Map<String, dynamic>?;
            if (customerdata == null) {
              return Center(
                child: Text('Document does not exist'),
              );
            }
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('business')
                  .doc(widget.docID)
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

                var data = snapshot.data?.data() as Map<String, dynamic>?;
                if (data == null) {
                  return Center(
                    child: Text('Document does not exist'),
                  );
                }
                return GeoLocationHelper().checkifWithinRadius(
                        targetLat: data['lat'],
                        targetLng: data['lng'],
                        centerLat: customerdata['lat'],
                        centerLng: customerdata['lng'])
                    ? GestureDetector(
                        onTap: () => {
                              Get.toNamed(BusinessInfo.id,
                                  arguments: [data, widget.docID])
                            },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(234, 234, 234, 1),
                                borderRadius:
                                    BorderRadius.circular(AppSizes.tweenSmall)),
                            child: Center(
                              child: (widget.typeFilter == 'all' ||
                                          widget.typeFilter == data['type']) &&
                                      (data['businessName']
                                          .toString()
                                          .toLowerCase()
                                          .contains(widget.businessNameFilter
                                              .toString()
                                              .toLowerCase()))
                                  ? ListTile(
                                      title: Text(
                                        data['businessName'] ?? "No data found",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(data['description'] ??
                                          "No data found"),
                                      leading: ClipRRect(
                                        child: Image.network(
                                          data['profilePicture'] ??
                                              "https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.extraLarge),
                                      ),
                                    )
                                  : Container(),
                            )))
                    : Container();
              },
            );
          }),
    );
  }
}
