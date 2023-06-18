import 'dart:io';

import 'package:hive_customer/data%20models/offers.dart';

class StoreInfo {
  String? businessName;
  String? description;
  String? phone;
  String? businessEmail;
  List<Offers>? offersList;

  String? address;

  String? businessType;
  double? businessLat;
  double? businessLng;

  File? profilePicFile;

  String? mondayStart;
  String? tuesdayStart;
  String? wednesdayStart;
  String? thursdayStart;
  String? fridayStart;
  String? saturdayStart;
  String? sundayStart;

  String? mondayEnd;
  String? tuesdayEnd;
  String? wednesdayEnd;
  String? thursdayEnd;
  String? fridayEnd;
  String? saturdayEnd;
  String? sundayEnd;

  StoreInfo(
      {this.businessName,
      this.description,
      this.phone,
      this.businessEmail,
      this.address,
      this.offersList,
      this.businessType,
      this.businessLat,
      this.businessLng,
      this.profilePicFile,
      this.mondayStart,
      this.mondayEnd,
      this.tuesdayStart,
      this.tuesdayEnd,
      this.wednesdayStart,
      this.wednesdayEnd,
      this.thursdayStart,
      this.thursdayEnd,
      this.fridayStart,
      this.fridayEnd,
      this.saturdayStart,
      this.saturdayEnd,
      this.sundayStart,
      this.sundayEnd});
}
