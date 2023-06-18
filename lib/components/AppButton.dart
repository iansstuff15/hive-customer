import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class AppButton extends StatefulWidget {
  double? width;
  double? height;
  String? text;
  double? textSize;
  FontWeight? textWeight;
  VoidCallback? onPressed;
  Color? background;
  Color? foreground;
  String? icon;
  AppButton(this.text, this.onPressed,
      {this.width = 150,
      this.height = 36,
      this.textWeight = FontWeight.bold,
      this.textSize = 16,
      this.background,
      this.foreground,
      this.icon});
  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(widget.background)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon != null
                  ? SvgPicture.asset(
                      'assets/google.svg',
                      width: AppSizes.small,
                      height: AppSizes.small,
                    )
                  : SizedBox(),
              SizedBox(
                width: widget.icon != null ? AppSizes.extraSmall : 0,
              ),
              Text(
                widget.text!,
                style: TextStyle(
                  color: widget.foreground,
                  fontWeight: widget.textWeight,
                  fontSize: widget.textSize,
                ),
              ),
            ],
          )),
    );
  }
}
