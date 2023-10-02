import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColor{

  static final Color primaryColor =  HexColor("#00AF87");
  static final Color selectedNavBarColor =  HexColor("#182F43");
  static const Color unselectedNavBarColor =  Colors.white;
  static final Color backgroundColor =  HexColor("#00AF87");

  static final appBarGradient = LinearGradient(
    colors: [
      HexColor("#00AF87"),
      HexColor("#00AF67"),
    ],
    stops: const [0.5, 1.0],
  );
  static const Color grey = Colors.grey;
  static final Color lightGrey = Colors.grey.withOpacity(0.2);
  static final Color mediumGrey = Colors.grey.withOpacity(0.5);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color transparent = Colors.transparent;
  static final Color navyBlue =  HexColor("#182F43");



}