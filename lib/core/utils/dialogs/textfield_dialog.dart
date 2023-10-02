import 'package:flutter/material.dart';
import 'package:maslaha/core/global/colors.dart';
import 'package:maslaha/core/global/localization.dart';
import 'package:maslaha/core/global/size_config.dart';

typedef DialogOptionsBuilder<T> = Map<String, T?> Function();

Future<T?> showTextFieldDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionsBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.navyBlue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: SizeConfig.screenWidth*0.5,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.all(8),
                    child: Text(content),
                  ),
                  const Text(EnglishLocalization.copy, style: TextStyle(color: AppColor.white),)
                ],
              ),
            )
          ],
        ),
        actions: options.keys.map((optionTitle) {
          final T value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
