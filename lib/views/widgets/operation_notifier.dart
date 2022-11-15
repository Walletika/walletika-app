import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import 'dialog.dart';
import 'snackbar.dart';
import 'spacer.dart';

class OperationNotifier {
  OperationNotifier({
    required this.title,
    this.args,
  });

  bool _isValid = false;
  bool _isError = false;
  String? _message;

  final String title;
  final Map<String, dynamic>? args;

  bool get isValid => _isValid;

  bool get isError => _isError;

  void valid(String message) {
    _isValid = true;
    _isError = false;
    _message = message;
  }

  void invalid(String message) {
    _isValid = false;
    _isError = false;
    _message = message;
  }

  void error(String message) {
    _isValid = false;
    _isError = true;
    _message = message;
  }

  void notify({
    String? title,
    bool backScreen = false,
  }) {
    if (backScreen) Get.back();

    if (_isError) {
      awesomeDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        body: Padding(
          padding: const EdgeInsets.only(left: AppDecoration.padding),
          child: Column(children: [
            Text(
              title ?? this.title,
              style: Get.theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "1025@global".tr,
              style: Get.theme.textTheme.titleLarge!.copyWith(
                color: Colors.red,
              ),
            ),
            verticalSpace(),
            verticalSpace(),
            Text(_message!),
            verticalSpace(),
            Text(
              "1019@global".tr,
              style: Get.theme.textTheme.bodySmall,
            ),
            verticalSpace(),
          ]),
        ),
        btnOkText: "1020@global".tr,
        btnOkOnPress: () => launchURL(AppInfo.website),
      ).show();
    } else {
      modernSnackBar(
        context: Get.context!,
        title: title ?? this.title,
        message: _message!,
        isSuccess: _isValid,
      );
    }
  }
}
