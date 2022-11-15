import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

SnackbarController modernSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  Icon? icon,
  bool? isSuccess,
  double maxWidth = 500.0,
  void Function(GetSnackBar)? onTap,
}) {
  if (icon == null && isSuccess is bool) {
    icon = isSuccess
        ? const Icon(
            LineIcons.check,
            color: AppColors.green,
            size: 30.0,
          )
        : const Icon(
            LineIcons.exclamationCircle,
            color: Colors.red,
            size: 40.0,
          );
  }

  return Get.snackbar(
    '',
    '',
    backgroundColor: AppColors.background3.withOpacity(0.5),
    leftBarIndicatorColor: icon?.color,
    titleText: Text(
      title,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
    messageText: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    icon: icon,
    maxWidth: maxWidth,
    padding: const EdgeInsets.all(AppDecoration.padding),
    margin: const EdgeInsets.all(AppDecoration.margin),
    borderRadius: AppDecoration.radius,
    onTap: onTap,
  );
}
