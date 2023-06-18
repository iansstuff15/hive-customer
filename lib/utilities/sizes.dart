import 'package:flutter/material.dart';

class AppSizes {
  static double extraSmall = 8;
  static double tweenSmall = extraSmall * 1.5; //12
  static double small = extraSmall * 2; //16
  static double mediumSmall = small * 1.5; //25
  static double medium = small * 2; //32
  static double mediumLarge = small * 2.5; //40
  static double large = medium * 2; //64
  static double extraLarge = large * 2; //128

  static double getWitdth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return width;
  }

  static double getHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.height;

    return width;
  }
}
