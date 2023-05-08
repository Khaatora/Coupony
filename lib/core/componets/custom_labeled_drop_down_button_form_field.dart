import 'package:flutter/material.dart';
import 'package:maslaha/core/global/colors.dart';

class CustomLabeledDropDownButtonFormField<T> extends StatelessWidget {
  const CustomLabeledDropDownButtonFormField({
    required this.value,
    required this.items,
    this.label,
    required this.onChanged,
    this.icon,
    this.iconSize = 24,
    this.selectedItemBuilder,
    this.decoration,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final T value;
  final List<T> items;
  final String? label;
  final void Function(Object?)? onChanged;
  final Widget? icon;
  final double iconSize;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final InputDecoration? decoration;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      label != null
          ? Text(
              label!,
              style: Theme.of(context).textTheme.titleMedium,
            )
          : const SizedBox.shrink(),
      DropdownButtonFormField<T>(
        value: value,
        decoration: decoration,
        icon: icon,
        iconSize: iconSize,
        selectedItemBuilder: selectedItemBuilder,
        itemHeight: kMinInteractiveDimension,
        items: items
            .map((value) => DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: this.value == value ? AppColor.black : AppColor.primaryColor,
                  ),
                  overflow: TextOverflow.visible,
                )))
            .toList(),
        onChanged: onChanged,
      ),
    ]);
  }
}
