import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TransactionPage extends StatelessWidget {
  static String id = 'TransactionPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.extraSmall),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: AppSizes.medium,
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.small)),
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              horizontal: AppSizes.small, vertical: AppSizes.small),
          padding: EdgeInsets.all(AppSizes.extraSmall),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.small),
                decoration: BoxDecoration(
                    color: AppColors.textBox,
                    borderRadius: BorderRadius.circular(AppSizes.extraLarge)),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: AppSizes.medium,
                ),
              ),
              SizedBox(
                height: AppSizes.tweenSmall,
              ),
              Text(
                'Order Success',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.mediumSmall),
              ),
              Text(
                'Reference: 123 456 789',
                style: TextStyle(fontSize: AppSizes.small),
              ),
              Text(
                '₱ 100.00',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppSizes.medium),
              ),
            ],
          ),
        ),
        TicketWidget(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.medium, vertical: AppSizes.small),
          color: AppColors.primary,
          isCornerRounded: true,
          width: AppSizes.getWitdth(context) * 0.9,
          height: AppSizes.getHeight(context) * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.mediumSmall,
                    color: AppColors.textBox),
              ),
              SizedBox(
                height: AppSizes.small,
              ),
              Text(
                'Service Availed',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.small,
                    color: AppColors.textBox),
              ),
              Text(
                'Service 1',
                style: TextStyle(
                    fontSize: AppSizes.small, color: AppColors.textColor),
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        'emailhere@gmail.com',
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Customer Phone',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        '09275552015',
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        'Cash',
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Customer Location',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        'Location Here',
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date to accomplish',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        '04/27/23',
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Time to accomplish',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        '01:03 pm',
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date Availed',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        '04/27/23',
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Time Availed',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.small,
                            color: AppColors.textBox),
                      ),
                      Text(
                        '01:03 pm',
                        style: TextStyle(
                            fontSize: AppSizes.small,
                            color: AppColors.textColor),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: AppSizes.extraSmall,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.textBox,
                        borderRadius: BorderRadius.circular(AppSizes.small)),
                    child: BarcodeWidget(
                      drawText: false,
                      barcode: Barcode.code128(),
                      height: AppSizes.getHeight(context) * 0.15,
                      padding: EdgeInsets.all(AppSizes.small),
                      data: 'Order UID here',
                    )),
              )
            ],
          ),
        )
      ],
    )));
  }
}
