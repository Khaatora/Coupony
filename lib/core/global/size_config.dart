import 'package:flutter/widgets.dart';

/// SizeConfig is used as a shared prefs substitute,
/// call the function init on an instance of this class to use its static variables
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double statusBarHeight;
  /// initializes all the static variables,
  /// call this function inside of the [build] function
  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth/100;
    blockSizeVertical = screenHeight/100;
    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal)/100;
    safeBlockVertical = (screenHeight - _safeAreaVertical)/100;
    statusBarHeight = _mediaQueryData.viewPadding.top;
  }
}