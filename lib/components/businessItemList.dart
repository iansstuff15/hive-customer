import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/sizes.dart';

import 'businessListItem.dart';

class BusinessItemList extends StatefulWidget {
  int? limit;
  String? typeFilter;
  String? nameFilter;
  bool? searchmode;
  BusinessItemList(
      {this.limit, this.typeFilter, this.nameFilter, this.searchmode = false});
  @override
  State<BusinessItemList> createState() => _BusinessItemListState();
}

class _BusinessItemListState extends State<BusinessItemList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.limit != null
          ? FirebaseFirestore.instance
              .collection('businessStatus')
              .limit(widget.limit!)
              .where("status", isEqualTo: true)
              .snapshots()
          : FirebaseFirestore.instance.collection('businessStatus').snapshots(),
      builder: (context, snapshot) {
        log("snapshot.toString()");
        log(snapshot.toString());
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // If there's data available, display it in a ListView
        var documents = snapshot.data!.docs;
        return ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: AppSizes.getHeight(context) * 0.6),
            child: ListView.separated(
              itemCount: documents.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSizes.small),
              itemBuilder: (context, index) {
                var data = documents[index].data();

                return BusinessListItem(
                  businessName: "businessName",
                  description: "description",
                  image: "image",
                  docID: data['uid'],
                  typeFilter: widget.typeFilter,
                  businessNameFilter: widget.nameFilter,
                );
              },
            ));
      },
    );
  }
}
