import 'package:flutter/material.dart';

class LabeledTextFormFieldWithTrailing extends StatelessWidget {
  LabeledTextFormFieldWithTrailing(
      {required this.textEditingController,
      this.trailing,
      required this.validator,
      required this.hintText,
      this.textInputAction,
      this.textInputType,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true,
      this.readOnly = false,
      this.onTap,
      Key? key})
      : super(key: key);

  final TextEditingController textEditingController;
  final Widget? trailing;
  final String? Function(String? value)? validator;
  final String? hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final void Function()? onTap;
  bool obscureText;
  bool enableSuggestions;
  bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
          suffixIcon: trailing,
          suffixIconColor: Colors.black,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleMedium,),
      validator: validator,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      onTap: onTap,
      readOnly: readOnly,
    );
  }
}
