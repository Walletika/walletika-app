import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.controller,
    this.initialValue,
    required this.placeholderText,
    this.prefixIcon,
    this.suffixIcon,
    this.showCounter = false,
    this.obscureText = false,
    this.enableIMEPersonalizedLearning = true,
    this.maxLength = 64,
    this.readOnly = false,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.validator,
    this.children = const <Widget>[],
    this.focusNode,
    super.key,
  }) {
    focusNode ??= FocusNode();
  }

  final TextEditingController controller;
  final String? initialValue;
  final String placeholderText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showCounter;
  final bool obscureText;
  final bool enableIMEPersonalizedLearning;
  final int maxLength;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String? text)? validator;
  final void Function(String text)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String text)? onFieldSubmitted;
  final void Function(String? text)? onSaved;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final List<Widget> children;
  late FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          focusNode: focusNode,
          obscureText: obscureText,
          enableSuggestions: !obscureText,
          autocorrect: !obscureText,
          enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          readOnly: readOnly,
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
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onTap: onTap,
          onChanged: (text) {
            if (onChanged != null) onChanged!(text);
            if (text.isEmpty) focusNode?.unfocus();
          },
          validator: (text) {
            if (text != null && text.isEmpty) return "1015@global".tr;
            if (validator != null) return validator!(text);
            return null;
          },
        ),
        ...children,
      ],
    );
  }
}
