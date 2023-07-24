import 'package:flutter/material.dart';
import 'package:maslaha/core/global/colors.dart';

class MainLabel extends StatelessWidget {
  const MainLabel({super.key, required this.text, this.imgPath, this.icon});

  final String text;
  final String? imgPath;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(constraints: const BoxConstraints(
          minHeight: 30
        ), child: imgPath!= null ? Image.asset(imgPath!): Icon(icon, color: AppColor.primaryColor),),
        const SizedBox(width: 8,),
        Text(text),
      ],
    );
  }
}
