import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/screens/services.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';

class UpdatePage extends StatelessWidget {
  static String id = 'UpdatePage';
  TextEditingController nameControlller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  UserStateController _userStateController = Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    final Map arguements = Get.arguments;
    final String name = arguements['name'];
    final String description = arguements['description'];
    final double price = arguements['price'];
    final String uid = arguements['uid'];

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: AppSizes.medium,
          ),
        ),
        Align(
          child: Text(
            'Update Item',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: AppSizes.medium),
          ),
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSizes.small)),
          padding: EdgeInsets.all(AppSizes.small),
          width: double.infinity,
          margin: EdgeInsets.all(AppSizes.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Information',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.small,
                    color: AppColors.textBox),
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Text(
                "Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.textBox),
              ),
              Text(name),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Text(
                "Description",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.textBox),
              ),
              Text(description),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Text(
                "Price",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.textBox),
              ),
              Text(price.toString()),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.container,
              borderRadius: BorderRadius.circular(AppSizes.small)),
          padding: EdgeInsets.all(AppSizes.small),
          width: double.infinity,
          margin: EdgeInsets.all(AppSizes.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.small,
                ),
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              AppInput("Name", TextInputType.name, nameControlller),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              AppInput(
                "Description",
                TextInputType.multiline,
                descriptionController,
                maxLines: 3,
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              AppInput("Price", TextInputType.number, priceController),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AppButton(
            "Save Update",
            () async {
              DocumentReference docref = FirebaseManager()
                  .db
                  .collection('business')
                  .doc(_userStateController.user.uid.value)
                  .collection('offers')
                  .doc(uid);
              log(docref.toString());
              log(nameControlller.text);
              log(descriptionController.text);
              log(priceController.text);

              if (nameControlller.text != '') {
                await docref.update({"name": nameControlller.text});
                log('done if');
              }
              if (descriptionController.text != '') {
                await docref
                    .update({"description": descriptionController.text});
                log('done if');
              }
              if (priceController.text != '') {
                await docref.update({"price": priceController.text});
                log('done if');
              }
              Get.toNamed(Services.id);
            },
            width: AppSizes.getWitdth(context) * 0.9,
          ),
        )
      ],
    ))));
  }
}
