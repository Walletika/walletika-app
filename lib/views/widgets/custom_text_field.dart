import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.controller,
    required this.placeholderText,
    this.prefixIcon,
    this.suffixIcon,
    this.showCounter = false,
    this.obscureText = false,
    this.enableIMEPersonalizedLearning = true,
    this.maxLength = 64,
    this.keyboardType,
    this.validator,
    this.children = const <Widget>[],
    this.focusNode,
    super.key,
  }) {
    focusNode ??= FocusNode();
  }

  final TextEditingController controller;
  final String placeholderText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showCounter;
  final bool obscureText;
  final bool enableIMEPersonalizedLearning;
  final int maxLength;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final List<Widget> children;
  late FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          enableSuggestions: !obscureText,
          autocorrect: !obscureText,
          enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
          keyboardType: keyboardType,
          maxLength: maxLength,
          decoration: InputDecoration(
            counter: showCounter ? null : zeroSpace(),
            prefixIcon: prefixIcon,
            label: Text(placeholderText),
            suffixIcon: suffixIcon,
            suffix: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  controller.clear();
                  focusNode?.unfocus();
                },
                child: const Icon(
                  LineIcons.times,
                  size: AppDecoration.iconSmallSize,
                ),
              ),
            ),
          ),
          onChanged: (value) {
            if (value.isEmpty) focusNode?.unfocus();
          },
          validator: (value) {
            if (value != null && value.isEmpty) return "1015@global".tr;
            if (validator != null) return validator!(value);
            return null;
          },
        ),
        ...children,
      ],
    );
  }
}
