import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_customer/data%20models/offers.dart';
import 'package:hive_customer/statemanagement/businessInfo/businessInfoModel.dart';
import 'package:hive_customer/statemanagement/offersInfo/offerInfoModel.dart';

class OfferInfoController extends GetxController {
  var offerInfo = OfferInfoModel();
  void clearList() {
    offerInfo.offerList.clear();
  }

  void removeItem(String elementUID) {
    log('in remove');
    offerInfo.offerList.removeWhere((element) => element.uid == elementUID);
    log('in remove');
  }

  void updateItem(Offers updateItem) {
    log('in update');

    Offers offerToUpdate = offerInfo.offerList
        .firstWhere((element) => element.uid == updateItem.uid);
    log(offerInfo.offerList.toString());
    log(offerToUpdate.toString());

    offerToUpdate.name = updateItem.name;
    offerToUpdate.description = updateItem.description;
    offerToUpdate.price = updateItem.price;
    log(offerToUpdate.toString());
    log(offerInfo.offerList.toString());
    log('out update');
  }

  void pushToList({required Offers offer}) {
    log('in offerlist');
    offerInfo.offerList.add(offer);
    log('out offerlist');
  }
}
