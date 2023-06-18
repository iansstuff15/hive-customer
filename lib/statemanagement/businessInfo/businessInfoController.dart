import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_customer/statemanagement/businessInfo/businessInfoModel.dart';

class BusinessInfoController extends GetxController {
  var businessInfo = BusinessInfoModel();

  void setBussinessInfo(
      {required String bussinessName,
      required String description,
      required String phone,
      required String bussinessEmail,
      required String bussinessType,
      required double bussinessLat,
      required double bussinessLng,
      required String profilePicture,
      required String mondayStart,
      required String mondayEnd,
      required String tuesdayStart,
      required String tuesdayEnd,
      required String wednesdayStart,
      required String wednesdayEnd,
      required String thursdayStart,
      required String thursdayEnd,
      required String fridayStart,
      required String fridayEnd,
      required String saturdayStart,
      required String saturdayEnd,
      required String sundayStart,
      required String sundayEnd,
      required String address,
      required String coverPhoto}) {
    log('in business info');
    businessInfo.businessName.value = bussinessName;
    businessInfo.description.value = description;
    businessInfo.phone.value = phone;
    businessInfo.businessEmail.value = bussinessEmail;
    businessInfo.businessType.value = bussinessType;
    businessInfo.businessLat.value = bussinessLat;
    businessInfo.businessLng.value = bussinessLng;
    businessInfo.profilePicFile.value = profilePicture;
    businessInfo.mondayStart.value = mondayStart;
    businessInfo.mondayEnd.value = mondayEnd;
    businessInfo.tuesdayStart.value = tuesdayStart;
    businessInfo.tuesdayEnd.value = tuesdayEnd;
    businessInfo.wednesdayStart.value = wednesdayStart;
    businessInfo.wednesdayEnd.value = wednesdayEnd;
    businessInfo.thursdayStart.value = thursdayStart;
    businessInfo.thursdayEnd.value = thursdayEnd;
    businessInfo.fridayStart.value = fridayStart;
    businessInfo.fridayEnd.value = fridayEnd;
    businessInfo.saturdayStart.value = saturdayStart;
    businessInfo.saturdayEnd.value = saturdayEnd;
    businessInfo.sundayStart.value = sundayStart;
    businessInfo.sundayEnd.value = sundayEnd;
    businessInfo.address.value = address;
    businessInfo.coverPhoto.value = coverPhoto;

    log('out business info');
  }
}
