import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/colors.dart';

import '../utilities/sizes.dart';

class NavigationButton extends StatefulWidget {
  String? label;
  Widget? icon;
  NavigationButton(this.label, this.icon, this.function);
  VoidCallback? function;
  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    String route = ModalRoute.of(context)!.settings.name!;
    return GestureDetector(
        onTap: widget.function,
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.extraSmall),
              margin: EdgeInsets.all(AppSizes.extraSmall),
              decoration: BoxDecoration(
                  color: route == widget.label!.toLowerCase()
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSizes.extraLarge)),
              child: widget.icon!,
            ),
            // Text(
            //   widget.label!,
            //   style: TextStyle(
            //     fontWeight: route == widget.label!.toLowerCase()
            //         ? FontWeight.bold
            //         : FontWeight.normal,
            //   ),
            // ),
          ],
        )));
  }
}
