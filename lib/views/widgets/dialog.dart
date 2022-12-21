import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

AwesomeDialog awesomeDialog({
  double? width = 500.0,
  DialogType dialogType = DialogType.noHeader,
  String? title,
  String? desc,
  Widget? body,
  String? btnOkText,
  void Function()? btnOkOnPress,
  String? btnCancelText,
  void Function()? btnCancelOnPress,
  bool autoDismiss = true,
}) {
  return AwesomeDialog(
    context: Get.context!,
    width: width,
    dialogBackgroundColor: Theme.of(Get.context!).backgroundColor,
    padding: const EdgeInsets.all(AppDecoration.padding),
    dialogType: dialogType,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,
    showCloseIcon: true,
    closeIcon: const Icon(LineIcons.times),
    title: title,
    titleTextStyle: Theme.of(Get.context!).textTheme.titleSmall,
    desc: desc,
    descTextStyle: Theme.of(Get.context!).textTheme.bodyMedium,
    body: body,
    btnOk: btnOkText is String
        ? SizedBox(
            height: AppDecoration.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                if (autoDismiss) Get.back();
                if (btnOkOnPress != null) btnOkOnPress();
              },
              child: Text(btnOkText),
            ),
          )
        : null,
    btnCancel: btnCancelText is String
        ? SizedBox(
            height: AppDecoration.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                if (autoDismiss) Get.back();
                if (btnCancelOnPress != null) btnCancelOnPress();
              },
              child: Text(btnCancelText),
            ),
          )
        : null,
  );
}
