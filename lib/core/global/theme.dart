import 'package:flutter/material.dart';
import 'package:maslaha/core/global/colors.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primaryColor,
    colorScheme: ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary:AppColor.primaryColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColor.white
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: AppBarTheme(
      color: AppColor.primaryColor,
      foregroundColor: AppColor.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
            AppColor.primaryColor,
        ),
        foregroundColor: const MaterialStatePropertyAll<Color>(
          Colors.white,
        ),
        minimumSize: const MaterialStatePropertyAll<Size>(
            Size(0, kMinInteractiveDimension-8),
        ),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll<Color>(
            Colors.transparent,
          )
      )
    ),
    textTheme: TextTheme(
        displaySmall: TextStyle(
            fontSize: 16.0,
            color: AppColor.primaryColor,
        ),
        titleSmall: TextStyle(
            color: AppColor.primaryColor,
          fontSize: 12.0,
        ),
        titleMedium: TextStyle(
          fontSize: 16.0,
          color: AppColor.primaryColor,
        ),
      headlineMedium: TextStyle(
        color: AppColor.primaryColor,
      ),
      headlineSmall: TextStyle(
        color: AppColor.primaryColor,
      ),
      labelLarge: const TextStyle(
        fontSize: 16.0,
      )
    ),
    dialogTheme: DialogTheme(
      surfaceTintColor: AppColor.primaryColor,
      shadowColor: AppColor.primaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.black,
      contentTextStyle: TextStyle(
        color: AppColor.white,
      ),
    )
  );
  static final dark = ThemeData(useMaterial3: true);
}
