import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

AwesomeDialog awesomeDialog({
  required BuildContext context,
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
    context: context,
    width: width,
    dialogBackgroundColor: Theme.of(context).backgroundColor,
    padding: const EdgeInsets.all(AppDecoration.padding),
    dialogType: dialogType,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,
    showCloseIcon: true,
    closeIcon: const Icon(LineIcons.times),
    title: title,
    desc: desc,
    body: body,
    btnOk: btnOkText is String
        ? SizedBox(
            height: AppDecoration.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                if (btnOkOnPress != null) btnOkOnPress();
                if (autoDismiss) Navigator.pop(context);
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
                if (btnCancelOnPress != null) btnCancelOnPress();
                if (autoDismiss) Navigator.pop(context);
              },
              child: Text(btnCancelText),
            ),
          )
        : null,
  );
}
