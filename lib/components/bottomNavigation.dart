import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/navigationButton.dart';
import 'package:hive_customer/screens/home.dart';
import 'package:hive_customer/screens/profile.dart';
import 'package:hive_customer/screens/services.dart';
import 'package:hive_customer/screens/transactions.dart';
import 'package:hive_customer/statemanagement/businessInfo/businessInfoController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class AppBottomNavigation extends StatelessWidget {
  BusinessInfoController _businessInfoController =
      Get.find<BusinessInfoController>();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: AppColors.container,
      height: AppSizes.getHeight(context) * 0.09,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.extraSmall),
      notchMargin: AppSizes.extraSmall,
      shape: CircularNotchedRectangle(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.large)),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavigationButton(
                    'Home',
                    Icon(
                      Icons.home_outlined,
                      size: AppSizes.medium,
                      color: AppColors.textColor,
                    ),
                    () => Get.offNamed(Home.id)),
                NavigationButton(
                    'Services',
                    Icon(
                      Icons.list,
                      size: AppSizes.medium,
                      color: AppColors.textColor,
                    ),
                    () => Get.offNamed(Services.id)),
                NavigationButton(
                    'Transactions',
                    Icon(
                      Icons.history,
                      size: AppSizes.medium,
                      color: AppColors.textColor,
                    ),
                    () => Get.offNamed(Transactions.id)),
                NavigationButton(
                    'Profile',
                    ClipRRect(
                      child: Image(
                        image: NetworkImage(_businessInfoController
                            .businessInfo.profilePicFile.value),
                        width: AppSizes.medium,
                        height: AppSizes.medium,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.extraLarge),
                    ),
                    () => {
                          Get.offNamed(
                            Profile.id,
                          )
                        })
              ])),
    );
  }
}
