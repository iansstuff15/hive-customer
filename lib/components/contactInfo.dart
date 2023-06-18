import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/screens/updateContactInfo.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

import '../statemanagement/businessInfo/businessInfoController.dart';

class ContactInfo extends StatelessWidget {
  final TextStyle style = TextStyle(fontSize: AppSizes.tweenSmall);
  final TextStyle styleDay =
      TextStyle(fontSize: AppSizes.tweenSmall, fontWeight: FontWeight.bold);
  BusinessInfoController _businessInfoController =
      Get.find<BusinessInfoController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Contact Information",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: AppSizes.mediumSmall),
              ),
              AppTextButton("Edit", () {
                Get.toNamed(UpdateContactPage.id);
              })
            ]),
            Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  // textDirection: TextDirection.rtl,
                  // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  // border:TableBorder.all(width: 2.0,color: Colors.red),
                  children: [
                    TableRow(children: [
                      Text(
                        "Phone",
                        style: styleDay,
                      ),
                      Obx(() => Text(
                            _businessInfoController.businessInfo.phone
                                .toString(),
                            style: style,
                          )),
                    ]),
                    // TableRow(children: [
                    //   Text(
                    //     "Email",
                    //     style: styleDay,
                    //   ),
                    //   Obx(() => Text(
                    //         _businessInfoController.businessInfo.businessEmail
                    //             .toString(),
                    //         style: style,
                    //       )),
                    // ]),
                  ],
                ),
              ),
            ])
          ],
        ));
  }
}
