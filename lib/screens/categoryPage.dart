import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/CustomerReviewItem.dart';
import 'package:hive_customer/components/businessItemList.dart';
import 'package:hive_customer/components/businessListItem.dart';
import 'package:hive_customer/components/locationSelector.dart';
import 'package:hive_customer/components/timeItem.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utilities/colors.dart';

class CategoryPage extends StatelessWidget {
  static String id = "categoryPage";
  TextEditingController search = TextEditingController();
  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.all(AppSizes.extraSmall),
        height: AppSizes.large + 11,
        child: AppInput("Search for a service", TextInputType.text, search),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: AppSizes.medium,
                  ),
                ),
              ]),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSizes.extraLarge)),
                padding: EdgeInsets.all(AppSizes.tweenSmall),
                child: SvgPicture.asset(
                  data[0].toString() == "Technician"
                      ? "assets/technician.svg"
                      : data[0].toString() == "Plumbing"
                          ? "assets/plumbing.svg"
                          : "assets/waterStation.svg",
                  width: AppSizes.large,
                  height: AppSizes.large,
                ),
              ),
              Text(
                data[0].toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              LocationSelector(),
              Padding(
                  padding: EdgeInsets.all(AppSizes.small),
                  child: BusinessItemList(
                    typeFilter: data[0],
                    nameFilter: search.text,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
