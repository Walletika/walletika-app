import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../utils/constants.dart';

class PinputFormField extends StatefulWidget {
  const PinputFormField({
    required this.controller,
    this.length = 6,
    this.autofocus = false,
    this.obscureText = false,
    this.readOnly = false,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onTap,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final int length;
  final bool autofocus;
  final bool obscureText;
  final bool readOnly;
  final void Function(String text)? onChanged;
  final void Function(String text)? onCompleted;
  final void Function(String text)? onSubmitted;
  final void Function()? onTap;
  final String? Function(String? text)? validator;

  @override
  State<PinputFormField> createState() => _PinputFormFieldState();
}

class _PinputFormFieldState extends State<PinputFormField> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40.0,
      height: 50.0,
      textStyle: Theme.of(context).textTheme.headlineSmall,
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(AppDecoration.radius),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      width: 45.0,
      height: 55.0,
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.highlight),
      ),
    );

    return SizedBox(
      height: focusedPinTheme.height! + 25.0,
      child: Pinput(
        length: widget.length,
        controller: widget.controller,
        focusNode: _focusNode,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        autofocus: widget.autofocus,
        preFilledWidget: Text(
          '_',
          style: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        pinAnimationType: PinAnimationType.slide,
        obscureText: widget.obscureText,
        enableSuggestions: false,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        readOnly: widget.readOnly,
        errorTextStyle: Theme.of(context).inputDecorationTheme.errorStyle,
        onCompleted: (text) {
          if (widget.onCompleted != null) widget.onCompleted!(text);
          _focusNode.unfocus();
        },
        onSubmitted: (text) {
          if (widget.onSubmitted != null) widget.onSubmitted!(text);
          _focusNode.unfocus();
        },
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        validator: (text) {
          if (text != null && (text.isEmpty || text.length != 6)) {
            return "1015@global".tr;
          }
          if (widget.validator != null) return widget.validator!(text);
          return null;
        },
      ),
    );
  }
}
