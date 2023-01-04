import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

void buttomSheet({
  required Widget widget,
  void Function()? onCompleted,
  bool isDismissible = true,
}) {
  Get.bottomSheet(
    widget,
    backgroundColor: Theme.of(Get.context!).backgroundColor,
    isDismissible: isDismissible,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDecoration.radiusBig),
      ),
    ),
  ).then((_) {
    if (onCompleted == null) return;

    onCompleted();
  });
}
