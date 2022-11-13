import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'custom_text_field.dart';

class PWValidatorStrings implements FlutterPwValidatorStrings {
  @override
  final String atLeast = "1000@PWValidator".tr;

  @override
  final String normalLetters = "1001@PWValidator".tr;

  @override
  final String uppercaseLetters = "1002@PWValidator".tr;

  @override
  final String numericCharacters = "1003@PWValidator".tr;

  @override
  final String specialCharacters = "1004@PWValidator".tr;
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    required this.controller,
    required this.placeholderText,
    this.enableStrengthBar = true,
    this.strengthBarWidth = 300.0,
    this.strengthBarHeight = 120.0,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String placeholderText;
  final bool enableStrengthBar;
  final double strengthBarWidth;
  final double strengthBarHeight;
  final String? Function(String? value)? validator;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  final FocusNode _focusController = FocusNode();
  bool _isObscureText = true;
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomTextFormField(
        controller: widget.controller,
        focusNode: _focusController,
        placeholderText: widget.placeholderText,
        obscureText: _isObscureText,
        enableIMEPersonalizedLearning: false,
        keyboardType: TextInputType.visiblePassword,
        prefixIcon: const Icon(LineIcons.key),
        suffixIcon: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => setState(() {
              _isObscureText = !_isObscureText;
              _focusController.requestFocus();
            }),
            child: Tooltip(
              message: "1009@global".tr,
              child: Icon(_isObscureText ? LineIcons.eye : LineIcons.eyeSlash),
            ),
          ),
        ),
        validator: (value) {
          if (widget.enableStrengthBar && !_isValid) return "1016@global".tr;
          if (widget.validator != null) return widget.validator!(value);
          return null;
        },
        children: widget.enableStrengthBar
            ? [
                FlutterPwValidator(
                  controller: widget.controller,
                  width: widget.strengthBarWidth,
                  height: widget.strengthBarHeight,
                  defaultColor: Theme.of(context).iconTheme.color!,
                  successColor: AppColors.green,
                  failureColor: Colors.orange,
                  minLength: 10,
                  uppercaseCharCount: 1,
                  numericCharCount: 3,
                  specialCharCount: 1,
                  normalCharCount: 3,
                  strings: PWValidatorStrings(),
                  onSuccess: () => _isValid = true,
                  onFail: () => _isValid = false,
                ),
              ]
            : [],
      ),
    ]);
  }
}
