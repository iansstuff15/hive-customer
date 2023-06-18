import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class AppTextButton extends StatefulWidget {
  double? width;
  double? height;
  String? text;
  double? textSize;
  FontWeight? textWeight;
  VoidCallback? onPressed;
  Color? background;
  Color? foreground;
  AppTextButton(this.text, this.onPressed,
      {this.width = 100,
      this.height = 36,
      this.textWeight = FontWeight.normal,
      this.textSize = 16,
      this.background,
      this.foreground});
  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(widget.background)),
        child: Text(
          widget.text!,
          style: TextStyle(
            color: widget.foreground,
            fontWeight: widget.textWeight,
            fontSize: widget.textSize,
          ),
        ),
      ),
    );
  }
}
