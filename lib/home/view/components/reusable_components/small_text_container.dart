import 'package:flutter/material.dart';
import 'package:maslaha/core/global/colors.dart';

class SmallTextContainer extends StatelessWidget {
  const SmallTextContainer({super.key, required this.text, this.onTap});
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.lightGrey,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text, textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
