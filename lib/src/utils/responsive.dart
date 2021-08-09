import 'package:flutter/material.dart';

class Responsive {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}

//Samsung galaxy a30 1080 x 2340
double responsiveHeight(double height) {
  double screenHeight = Responsive.screenHeight;
  return (height / 812.0) * screenHeight;
}

double responsiveWidth(double width) {
  double screenWidth = Responsive.screenWidth;
  return (width / 375.0) * screenWidth;
}

double responsiveText(double size) {
  double screenHeight = Responsive.screenHeight;
  return (size / 812.0) * screenHeight;
}

bool isPotrait() {
  return Orientation.portrait == Responsive.orientation ? true : false;
}
