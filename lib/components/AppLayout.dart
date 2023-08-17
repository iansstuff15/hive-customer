import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/addService.dart';
import 'package:hive_customer/components/bottomNavigation.dart';

import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class AppLayout extends StatefulWidget {
  Widget? body;
  bool? safeTop;
  AppLayout(this.body, {this.safeTop = true});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  UserStateController _userStateController = Get.find<UserStateController>();

  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      // floatingActionButton: Get.currentRoute != 'transactions'
      //     ? FloatingActionButton(
      //         onPressed: () {},
      //         child: Icon(Icons.shopping_cart_outlined),
      //       )
      //     : null,
      bottomNavigationBar: AppBottomNavigation(),
      body: SafeArea(top: widget.safeTop!, child: widget.body!),
    );
  }
}

Widget _buildBottomSheet(
  BuildContext context,
  ScrollController scrollController,
  double bottomSheetOffset,
) {
  return Material(
    child: AddService(),
  );
}
