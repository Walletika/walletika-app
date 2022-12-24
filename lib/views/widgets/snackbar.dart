import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

SnackbarController modernSnackBar({
  Icon? icon,
  String? title,
  String? message,
  bool? isSuccess,
  double maxWidth = 400.0,
  void Function(GetSnackBar)? onTap,
}) {
  if (isSuccess != null) {
    icon = isSuccess
        ? const Icon(
            Icons.check_rounded,
            color: AppColors.green,
            size: 30.0,
          )
        : const Icon(
            LineIcons.exclamationTriangle,
            color: Colors.orange,
            size: 30.0,
          );
  }

  final TextTheme textTheme = Theme.of(Get.context!).textTheme;

  return Get.rawSnackbar(
    backgroundColor: Colors.black87,
    leftBarIndicatorColor: icon?.color,
    barBlur: 0,
    maxWidth: maxWidth,
    snackPosition: SnackPosition.TOP,
    borderRadius: AppDecoration.radius,
    margin: const EdgeInsets.all(AppDecoration.margin),
    padding: EdgeInsets.symmetric(
      horizontal: AppDecoration.paddingMedium,
      vertical:
          title != null ? AppDecoration.padding : AppDecoration.paddingMedium,
    ),
    icon: icon,
    titleText: title != null
        ? Text(
            title,
            style: textTheme.titleSmall!.copyWith(
              color: icon?.color ?? Colors.white,
            ),
          )
        : null,
    messageText: message != null
        ? Text(
            message,
            style: textTheme.bodySmall!.copyWith(
              color: icon?.color ?? Colors.white,
            ),
          )
        : null,
    onTap: onTap,
  );
}
