import 'package:flutter/material.dart';
import 'package:maslaha/core/global/colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, this.onTap, this.color, this.borderRadius, this.fontSize, this.textColor, this.height, this.width});
  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final Color? textColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(25),
        color: color ?? AppColor.lightGrey,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text, textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: textColor,
              fontSize: fontSize ?? 13.0,
            ),
          ),
        ),
      ),
    );
  }
}
