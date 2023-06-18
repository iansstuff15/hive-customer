import 'package:get/get.dart';
import 'package:hive_customer/statemanagement/user/userModel.dart';

class UserStateController extends GetxController {
  var user = UserModel();

  void setUserData(String email, String uid) {
    user.email.value = email;
    user.uid.value = uid;
  }
}
