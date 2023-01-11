import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

AwesomeDialog awesomeDialog({
  double? width = 500.0,
  DialogType dialogType = DialogType.noHeader,
  EdgeInsetsGeometry? padding,
  String? title,
  String? desc,
  Widget? body,
  String? btnOkText,
  void Function()? btnOkOnPress,
  String? btnCancelText,
  void Function()? btnCancelOnPress,
  bool autoDismiss = true,
  bool showCloseIcon = false,
  bool dismissOnBackKeyPress = true,
  bool dismissOnTouchOutside = true,
  void Function(DismissType)? onDismissCallback,
}) {
  final TextTheme textTheme = Theme.of(Get.context!).textTheme;

  if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

  return AwesomeDialog(
    context: Get.context!,
    width: width,
    dialogBackgroundColor: Theme.of(Get.context!).backgroundColor,
    padding: padding ??
        const EdgeInsets.symmetric(
          horizontal: AppDecoration.paddingMedium,
          vertical: AppDecoration.padding,
        ),
    dialogType: dialogType,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,
    showCloseIcon: showCloseIcon,
    dismissOnBackKeyPress: dismissOnBackKeyPress,
    dismissOnTouchOutside: dismissOnTouchOutside,
    onDismissCallback: onDismissCallback,
    closeIcon: const Icon(LineIcons.times),
    title: title,
    titleTextStyle: textTheme.bodyLarge!.copyWith(fontFamily: AppFonts.bold),
    desc: desc,
    descTextStyle: textTheme.bodyMedium,
    body: body,
    btnOk: btnOkText is String
        ? SizedBox(
            height: AppDecoration.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                if (autoDismiss) Get.back();
                if (btnOkOnPress != null) btnOkOnPress();
              },
              child: Text(
                btnOkText,
                style: textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
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
              child: Text(
                btnCancelText,
                style: textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
            ),
          )
        : null,
  );
}
