import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class TimeItem extends StatefulWidget {
  String? start;
  String? end;
  String? day;
  TimeItem({required this.start, required this.end, required this.day});
  @override
  State<TimeItem> createState() => _TimeItemState();
}

class _TimeItemState extends State<TimeItem> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.day!,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: AppSizes.tweenSmall),
      ),
      Row(
        children: [
          Icon(
            Icons.timer,
            color: AppColors.primary,
            size: AppSizes.tweenSmall,
          ),
          Text(
            widget.start! == 'Start' ? 'Not available' : widget.start!,
            style: TextStyle(fontSize: AppSizes.extraSmall),
          ),
          Icon(
            Icons.arrow_right_alt,
            color: AppColors.primary,
          ),
          Icon(
            Icons.timer,
            color: AppColors.primary,
            size: AppSizes.tweenSmall,
          ),
          Text(
            widget.end! == 'End' ? 'Not available' : widget.end!,
            style: TextStyle(fontSize: AppSizes.extraSmall),
          ),
        ],
      )
    ]);
  }
}
