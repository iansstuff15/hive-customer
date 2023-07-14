import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class ServiceButton extends StatefulWidget {
  String? label;
  Widget? icon;
  ServiceButton({required this.label, required icon});
  @override
  State<ServiceButton> createState() => _ServiceButtonState();
}

class _ServiceButtonState extends State<ServiceButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.small, vertical: AppSizes.tweenSmall),
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSizes.extraSmall)),
      child: Column(
        children: [
          widget.icon!,
          Text(
            widget.label!,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
