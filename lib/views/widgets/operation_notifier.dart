import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import 'dialog.dart';
import 'snackbar.dart';
import 'spacer.dart';

enum OperationState { idle, running, valid, invalid, error }

class OperationNotifier {
  OperationNotifier({
    required this.id,
    this.args,
  });

  final String id;
  final Map<String, dynamic>? args;

  OperationState _state = OperationState.idle;
  String? _message;

  OperationState get state => _state;

  bool get isIdle => _state == OperationState.idle;

  bool get isRunning => _state == OperationState.running;

  bool get isValid => _state == OperationState.valid;

  bool get isInvalid => _state == OperationState.invalid;

  bool get isError => _state == OperationState.error;

  Future<void> run({
    required Future<bool> Function() callback,
    String? title,
    String? validMessage,
    String? invalidMessage,
    bool closeScreenWhenValid = false,
    bool closeScreenWhenInvalid = false,
    bool closeScreenWhenError = false,
    void Function()? onValid,
    void Function()? onInvalid,
    void Function()? onError,
  }) async {
    if (isRunning || Get.isSnackbarOpen) return;

    _state = OperationState.running;

    await callback().then((isValid) {
      if (isValid) {
        if (onValid != null) onValid();

        if (validMessage != null) {
          valid(validMessage);
          notify(title: title, closeScreen: closeScreenWhenValid);
        }
      } else {
        if (onInvalid != null) onInvalid();

        if (invalidMessage != null) {
          invalid(invalidMessage);
          notify(title: title, closeScreen: closeScreenWhenInvalid);
        }
      }
    }).catchError((e) {
      if (onError != null) onError();

      error(e.toString());
      notify(closeScreen: closeScreenWhenError);
    });

    _reset();
  }

  void valid(String message) {
    _state = OperationState.valid;
    _message = message;
  }

  void invalid(String message) {
    _state = OperationState.invalid;
    _message = message;
  }

  void error(String message) {
    _state = OperationState.error;
    _message = message;
  }

  void notify({
    String? title,
    bool closeScreen = false,
  }) {
    assert(_message != null, "The state must be called before being notified");

    if (closeScreen) Get.back();

    if (isError) {
      final TextTheme textTheme = Theme.of(Get.context!).textTheme;

      awesomeDialog(
        dialogType: DialogType.error,
        body: Column(
          children: [
            Text(
              "1025@global".tr,
              style: textTheme.bodyMedium!.copyWith(
                color: Colors.red,
                fontFamily: AppFonts.medium,
              ),
            ),
            verticalSpace(AppDecoration.spaceSmall),
            Text(id, style: textTheme.bodySmall),
            verticalSpace(),
            Text(_message!, style: textTheme.bodySmall),
            verticalSpace(),
            Text(
              "1019@global".tr,
              style: textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            verticalSpace(),
          ],
        ),
        btnOkText: "1020@global".tr,
        btnOkOnPress: () => launchURL(AppInfo.website),
      ).show();
    } else if (isValid || isInvalid) {
      modernSnackBar(
        title: title,
        message: _message,
        isSuccess: isValid,
      );
    }

    _reset();
  }

  void _reset() {
    _state = OperationState.idle;
    _message = null;
  }
}
