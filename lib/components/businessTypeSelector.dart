import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class BusinessTypeSelector extends StatefulWidget {
  String? label;
  String? imagePath;
  String? selectedType;
  VoidCallback? onTap;
  BusinessTypeSelector(
      this.label, this.imagePath, this.selectedType, this.onTap);
  @override
  State<BusinessTypeSelector> createState() => _BusinessTypeSelectorState();
}

class _BusinessTypeSelectorState extends State<BusinessTypeSelector> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.medium),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.small),
              color: widget.selectedType != widget.label
                  ? AppColors.container
                  : AppColors.primary),
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.tweenSmall, vertical: AppSizes.tweenSmall),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.tweenSmall),
                child: Image(
                  image: AssetImage(widget.imagePath!),
                  height: 120,
                  width: AppSizes.getWitdth(context) * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: AppSizes.tweenSmall,
              ),
              Text(
                widget.label!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.small,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
