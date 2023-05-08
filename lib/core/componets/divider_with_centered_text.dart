import 'package:flutter/material.dart';

import '../global/colors.dart';

class DividerWithCenteredText extends StatelessWidget {
  const DividerWithCenteredText({this.centeredText = "or", this.color = AppColor.grey,Key? key}) : super(key: key);

  final String centeredText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
              thickness: 1,
              endIndent: 8,
              color: Colors.black,
            )),
        Text(centeredText,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
              color: color,
            )),
        const Expanded(
            child: Divider(
              thickness: 1,
              indent: 8,
              color: Colors.black,
            )),
      ],
    );
  }
}
