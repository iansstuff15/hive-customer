import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class ReviewItem extends StatefulWidget {
  const ReviewItem({super.key});

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: AppSizes.getWitdth(context)),
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(AppSizes.small)),
            child: Row(children: [
              ClipRRect(
                child: Image(
                    image: AssetImage('assets/user.png'),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(AppSizes.small),
              ),
              SizedBox(
                width: AppSizes.extraSmall,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: AppSizes.getWitdth(context) * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Montiero, Gilbert',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.small,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '04/29/2023',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.tweenSmall,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                      RatingStars(
                        value: 3.5,
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                        ),
                        starCount: 5,
                        starSize: 20,
                        maxValue: 5,
                        starSpacing: 2,
                        maxValueVisibility: true,
                        valueLabelVisibility: false,
                        animationDuration: Duration(milliseconds: 1000),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: AppColors.primary,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: AppSizes.getWitdth(context) * 0.65,
                    height: 35,
                    child: Text(
                      "Lorem ipsum dolor sit amet, incididunt elit occaecat dolore duis elit pariatur anim cupidatat eiusmod incididunt sunt labore tempor est esse.",
                      style: TextStyle(
                          fontSize: AppSizes.tweenSmall,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                  )
                ],
              )
            ])));
  }
}
