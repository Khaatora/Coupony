import 'package:flutter/material.dart';

extension UnFocusKeyboardFromScope on BuildContext {
  void unFocusKeyboardFromScope() {
    FocusScope.of(this).unfocus();
  }
}

extension SnackBarActions on BuildContext {
  void showCustomSnackBar(String text, Duration? duration, [Color? color]) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: duration ?? const Duration(seconds: 4),
      content: Center(
        child: Text(text),
      ),
    ));
  }
  void hideCurrentSnackBar(){
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
}
