import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppLayout.dart';
import 'package:hive_customer/components/chart/bar_charts.dart';
import 'package:hive_customer/components/customerSection.dart';
import 'package:hive_customer/components/location.dart';
import 'package:hive_customer/components/servicesGrid.dart';
import 'package:hive_customer/components/transactionsGrid.dart';
import 'package:hive_customer/components/card.dart';
import 'package:hive_customer/components/earningsSection.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

import '../statemanagement/businessInfo/businessInfoController.dart';

class Home extends StatelessWidget {
  static String id = 'home';

  @override
  Widget build(BuildContext context) {
    final BusinessInfoController businessInfoController =
        BusinessInfoController();
    return AppLayout(Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.small,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.tweenSmall,
            ),
            AppLocation(),
            SizedBox(
              height: AppSizes.tweenSmall,
            ),
            AppCard(),
            SizedBox(
              height: AppSizes.medium,
            ),
            EarningsSection(),
            SizedBox(
              height: AppSizes.medium,
            ),
            CustomerSection(),
            SizedBox(
              height: AppSizes.medium,
            ),
            TransactionGrid(),
            SizedBox(
              height: AppSizes.medium,
            ),
          ],
        ),
      ),
    ));
  }
}
