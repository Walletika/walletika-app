import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'custom_text_field.dart';

class AddressFormField extends StatelessWidget {
  const AddressFormField({
    required this.controller,
    required this.placeholderText,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.children = const <Widget>[],
    super.key,
  });

  final TextEditingController controller;
  final String placeholderText;
  final void Function(String text)? onChanged;
  final void Function()? onEditingComplete;
  final String? Function(String? text)? validator;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      placeholderText: placeholderText,
      maxLength: 42,
      prefixIcon: const Icon(LineIcons.paste),
      keyboardType: TextInputType.none,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      inputFormatters: [FilteringTextInputFormatter.allow(AppRegExp.address)],
      validator: validator,
      children: children,
    );
  }
}
