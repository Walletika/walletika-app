import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

SnackbarController modernSnackBar({
  required String title,
  required String message,
  Icon? icon,
  bool? isSuccess,
  double maxWidth = 500.0,
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

  return Get.snackbar(
    '',
    '',
    backgroundColor: Colors.black87,
    leftBarIndicatorColor: icon?.color,
    barBlur: 0,
    titleText: Text(
      title,
      style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
            color: icon?.color ?? Colors.white,
          ),
    ),
    messageText: Text(
      message,
      style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
            color: icon?.color ?? Colors.white,
          ),
    ),
    icon: icon,
    maxWidth: maxWidth,
    padding: const EdgeInsets.symmetric(
      horizontal: AppDecoration.paddingMedium,
      vertical: AppDecoration.padding,
    ),
    margin: const EdgeInsets.all(AppDecoration.margin),
    borderRadius: AppDecoration.radius,
    onTap: onTap,
  );
}
