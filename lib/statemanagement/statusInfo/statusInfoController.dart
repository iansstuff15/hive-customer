import 'package:hive_customer/statemanagement/statusInfo/statusInfoModel.dart';

class StatusInfoController {
  var statusInfo = StatusInfoModel();
  void setStatus({required bool status}) {
    statusInfo.isOnline.value = status;
  }
}
