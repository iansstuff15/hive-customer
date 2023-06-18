import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_customer/components/statistics.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

import 'chart/bar_charts.dart';

class EarningsSection extends StatelessWidget {
  const EarningsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Earnings',
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.mediumSmall),
        ),
        SizedBox(
          height: AppSizes.extraSmall,
        ),
        Statistics(),
        SizedBox(
          height: AppSizes.extraSmall,
        ),
        AppBarChart()
      ],
    );
  }
}
