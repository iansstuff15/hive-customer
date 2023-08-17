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

class AppSearch extends StatefulWidget {
  static String id = "search";

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  TextEditingController search = TextEditingController();
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // Set focus after a short delay to allow the widget tree to build
    Future.delayed(Duration(milliseconds: 10000), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.all(AppSizes.extraSmall),
        height: AppSizes.large + 11,
        child: AppInput(
          "Search for a service",
          TextInputType.text,
          search,
          focus: true,
        ),
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
              LocationSelector(),
              Padding(
                  padding: EdgeInsets.all(AppSizes.extraSmall),
                  child: BusinessItemList(
                    typeFilter: 'all',
                    nameFilter: search.text,
                    searchmode: true,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
