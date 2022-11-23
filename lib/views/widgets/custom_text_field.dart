import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class CustomTextFormField extends StatefulWidget {
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
  });

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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    widget.focusNode ??= FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          initialValue: widget.initialValue,
          focusNode: widget.focusNode,
          obscureText: widget.obscureText,
          enableSuggestions: !widget.obscureText,
          autocorrect: !widget.obscureText,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            counter: widget.showCounter ? null : zeroSpace(),
            prefixIcon: widget.prefixIcon,
            label: Text(widget.placeholderText),
            suffixIcon: widget.suffixIcon,
            suffix: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  widget.controller.clear();
                  widget.focusNode?.unfocus();
                },
                child: const Icon(
                  LineIcons.times,
                  size: AppDecoration.iconSmallSize,
                ),
              ),
            ),
          ),
          onEditingComplete: () {
            if (widget.onEditingComplete != null) widget.onEditingComplete!();
            widget.focusNode?.unfocus();
          },
          onFieldSubmitted: (text) {
            if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!(text);
            widget.focusNode?.unfocus();
          },
          onSaved: widget.onSaved,
          onTap: widget.onTap,
          onChanged: (text) {
            if (widget.onChanged != null) widget.onChanged!(text);
            if (text.isEmpty) widget.focusNode?.unfocus();
          },
          validator: (text) {
            if (text != null && text.isEmpty) return "1015@global".tr;
            if (widget.validator != null) return widget.validator!(text);
            return null;
          },
        ),
        ...widget.children,
      ],
    );
  }
}
