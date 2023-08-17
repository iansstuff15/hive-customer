import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppLayout.dart';
import 'package:hive_customer/components/AppRating.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/components/FeaturedImage.dart';
import 'package:hive_customer/components/businessItemList.dart';
import 'package:hive_customer/components/businessListItem.dart';
import 'package:hive_customer/components/card.dart';
import 'package:hive_customer/components/contactInfo.dart';
import 'package:hive_customer/components/editUserInfo.dart';
import 'package:hive_customer/components/logoutConfirm.dart';
import 'package:hive_customer/components/storeHours.dart';
import 'package:hive_customer/utilities/colors.dart';

import '../utilities/sizes.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});
  static String id = 'explore';

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final _controller = ValueNotifier('all');
  String _textValue = '';
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    search.addListener(_updateTextValue);
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  _updateTextValue() {
    setState(() {
      _textValue = search.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.medium, vertical: AppSizes.extraSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSizes.extraSmall,
                ),
                Text(
                  'Explore',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.mediumLarge),
                ),
                SizedBox(
                  height: AppSizes.small,
                ),
                AdvancedSegment(
                  controller: _controller,
                  inactiveStyle: TextStyle(fontSize: AppSizes.tweenSmall),
                  activeStyle: TextStyle(
                      fontSize: AppSizes.tweenSmall,
                      fontWeight: FontWeight.bold),
                  segments: const {
                    'all': 'All',
                    'Water Refilling Station': 'Water Station',
                    'Technician': 'Technician',
                    'Plumbing': 'Plumbing',
                  },
                ),
                SizedBox(
                  height: AppSizes.small,
                ),
                ValueListenableBuilder<String>(
                  valueListenable: _controller,
                  builder: (_, key, __) {
                    return BusinessItemList(
                      nameFilter: _textValue,
                      typeFilter: key,
                    );
                  },
                ),
                AppInput("Search for a service", TextInputType.text, search),
                SizedBox(
                  height: AppSizes.small,
                ),
              ],
            ))));
  }
}
