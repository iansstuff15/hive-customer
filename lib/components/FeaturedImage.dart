import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/screens/updateFeaturedImages.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:newsfeed_multiple_imageview/newsfeed_multiple_imageview.dart';

class FeaturedImage extends StatefulWidget {
  @override
  State<FeaturedImage> createState() => _FeaturedImageState();
}

class _FeaturedImageState extends State<FeaturedImage> {
  List<String> _imageUrls = [
    "https://images.pexels.com/photos/158028/bellingrath-gardens-alabama-landscape-scenic-158028.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/158028/bellingrath-gardens-alabama-landscape-scenic-158028.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/158028/bellingrath-gardens-alabama-landscape-scenic-158028.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.unsplash.com/photo-1573155993874-d5d48af862ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cGFya3xlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://media.istockphoto.com/photos/colorful-sunset-at-davis-lake-picture-id1184692500?k=20&m=1184692500&s=612x612&w=0&h=7noTRS8UjiAVKU92eIhPG17PIWVh-kCmH5jKX5GOcdQ=",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.small),
        child: Column(
          children: [
            // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //   Text(
            //     "Featured Images",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: AppColors.primary,
            //         fontSize: AppSizes.mediumSmall),
            //   ),
            //   AppTextButton("Edit", () {
            //     Get.toNamed(UpdateFeaturedImagePage.id);
            //   }),
            // ]),
            // GestureDetector(
            //     onTap: () {
            //       Get.toNamed(UpdateFeaturedImagePage.id);
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //           color: AppColors.textBox,
            //           borderRadius: BorderRadius.circular(AppSizes.small)),
            //       width: double.infinity,
            //       height: AppSizes.large,
            //       child: Icon(Icons.add),
            //     ))
            // NewsfeedMultipleImageView(
            //   imageUrls: _imageUrls,
            //   marginLeft: 10.0,
            //   marginRight: 10.0,
            //   marginBottom: 10.0,
            //   marginTop: 10.0,
            // )
          ],
        ));
  }
}
