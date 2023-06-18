import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart ';

import '../utilities/colors.dart';
import '../utilities/sizes.dart';

class Service extends StatefulWidget {
  String? label;
  IconData? icon;
  Service(this.label, this.icon);
  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    return Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.small),
          color: AppColors.container,
        ),
        child: InkWell(
            onTap: () {
              // do something
            },
            borderRadius: BorderRadius.circular(AppSizes.small),
            child: Container(
              width: AppSizes.getWitdth(context) * 0.29,
              height: 100,
              padding: EdgeInsets.all(AppSizes.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    widget.icon!,
                    size: AppSizes.mediumLarge,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    height: AppSizes.tweenSmall,
                  ),
                  Text(
                    widget.label!,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )
                ],
              ),
            )));
  }
}
