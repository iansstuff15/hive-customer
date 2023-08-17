import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/navigationButton.dart';
import 'package:hive_customer/screens/explore.dart';
import 'package:hive_customer/screens/home.dart';
import 'package:hive_customer/screens/profile.dart';

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
      color: Colors.white,
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
                    'Explore',
                    Icon(
                      Icons.explore_outlined,
                      size: AppSizes.medium,
                      color: AppColors.textColor,
                    ),
                    () => Get.offNamed(Explore.id)),
                NavigationButton(
                    'Transactions',
                    SvgPicture.asset(
                      'assets/transactions.svg',
                      width: AppSizes.mediumLarge,
                      height: AppSizes.medium,
                    ),
                    () => Get.offNamed(Transactions.id)),
                NavigationButton(
                    'Profile',
                    ClipRRect(
                      child: Image(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/hive-5eb83.appspot.com/o/images%2FDprdgoYHpYhT1IwQX65eaFrxIlA2%2Fprofile?alt=media&token=68884301-383f-4203-8d98-4642a6ec9ed4'),
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
