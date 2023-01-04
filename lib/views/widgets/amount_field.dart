import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/amount_formatter.dart';
import '../../utils/constants.dart';
import 'custom_text_field.dart';
import 'item_logo.dart';

class AmountFormField extends StatelessWidget {
  const AmountFormField({
    required this.controller,
    this.showMaxButton = false,
    this.imageURL,
    this.balance,
    super.key,
  });

  final TextEditingController controller;
  final bool showMaxButton;
  final String? imageURL;
  final double? balance;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTextFormField(
      controller: controller,
      placeholderText: "1037@global".tr,
      maxLength: 40,
      keyboardType: TextInputType.number,
      inputFormatters: [AmountFormatter()],
      prefixIcon: imageURL != null
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDecoration.padding,
              ),
              child: ItemLogo(
                imageURL: imageURL!,
                size: AppDecoration.iconSize,
              ),
            )
          : null,
      suffixIcon: showMaxButton && balance != null
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDecoration.padding,
              ),
              child: SizedBox(
                width: 50.0,
                child: ElevatedButton(
                  onPressed: _maxAmountOnPressed,
                  child: Text(
                    "1038@global".tr,
                    style: textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          : null,
      validator: balance != null
          ? (text) {
              if (text != null && double.parse(text) > balance!) {
                return "1040@global".tr;
              }
              return null;
            }
          : null,
    );
  }

  void _maxAmountOnPressed() {
    controller.text = balance.toString();
  }
}
