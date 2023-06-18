import 'package:flutter/material.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/components/chart/bar_charts.dart';
import 'package:hive_customer/components/chart/review_bars.dart';
import 'package:hive_customer/components/reviewItem.dart';
import 'package:hive_customer/utilities/colors.dart';

import '../utilities/sizes.dart';

class AppRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: AppSizes.small),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Business Reviews',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.mediumSmall),
                      ),
                      SizedBox(
                        height: AppSizes.extraSmall,
                      ),
                      Text(
                        'Overall Score',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small),
                      ),
                      Text(
                        '3.25',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.large),
                      )
                    ],
                  ),
                  width: AppSizes.getWitdth(context) * 0.5,
                ),
                SizedBox(
                  child: AppReviewBarChart(),
                  width: AppSizes.getWitdth(context) * 0.4,
                  height: 150,
                )
              ],
            ),
            SizedBox(
              height: AppSizes.extraSmall,
            ),
            AppTextButton("View All", () {}),
            SizedBox(
              height: AppSizes.extraSmall,
            ),
            SizedBox(
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return ReviewItem();
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: AppSizes.extraSmall,
                      ),
                  itemCount: 5),
              height: AppSizes.getHeight(context) * 0.5,
            ),
          ],
        ));
  }
}
