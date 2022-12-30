import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/dialog.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/password_field.dart';
import '../widgets/progress.dart';
import '../widgets/spacer.dart';
import '../widgets/warning.dart';

class BackupView {
  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();
  final OperationNotifier _backupOperation = OperationNotifier(
    id: "0xa8eB426A",
  );

  String? _directory;

  void backupOnPressed() {
    if (Get.isSnackbarOpen) return;

    FilePicker.platform.getDirectoryPath(lockParentWindow: true).then((result) {
      _directory = result;

      if (_directory == null) return;

      final TextTheme textTheme = Theme.of(Get.context!).textTheme;

      awesomeDialog(
        body: Column(children: [
          Text("1005@settings".tr, style: textTheme.titleSmall),
          verticalSpace(AppDecoration.spaceMedium),
          Text("1009@settings".tr, textAlign: TextAlign.center),
          verticalSpace(),
          Text(
            "1010@settings".tr,
            style: textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Wrap(
            spacing: AppDecoration.space,
            runSpacing: AppDecoration.space,
            children: [
              SizedBox(
                width: 170.0,
                height: AppDecoration.buttonHeight,
                child: ElevatedButton(
                  onPressed: _specificPasswordOnPressed,
                  child: Text(
                    "1011@settings".tr,
                    style: textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 170.0,
                height: AppDecoration.buttonHeight,
                child: ElevatedButton(
                  onPressed: _defaultPasswordOnPressed,
                  child: Text(
                    "1012@settings".tr,
                    style: textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(AppDecoration.spaceMedium),
        ]),
      ).show();
    });
  }

  void _specificPasswordOnPressed() {
    Get.back();

    awesomeDialog(
      onDismissCallback: (_) {
        _passwordController.clear();
        _confirmPassController.clear();
      },
      body: Form(
        key: _formController,
        child: Column(children: [
          Text("1013@settings".tr, textAlign: TextAlign.center),
          verticalSpace(AppDecoration.spaceMedium),
          WarningText(text: "1014@settings".tr),
          verticalSpace(AppDecoration.spaceMedium),
          PasswordFormField(
            controller: _passwordController,
            placeholderText: "1011@global".tr,
            onEditingComplete: _confirmPasswordOnSubmit,
          ),
          verticalSpace(),
          PasswordFormField(
            controller: _confirmPassController,
            placeholderText: "1012@global".tr,
            enableStrengthBar: false,
            validator: (text) {
              if (text != null && text != _passwordController.text) {
                return "1017@global".tr;
              }
              return null;
            },
            onEditingComplete: _confirmPasswordOnSubmit,
          ),
          verticalSpace(),
          SizedBox(
            width: AppDecoration.widgetWidth,
            height: AppDecoration.buttonHeightLarge,
            child: ElevatedButton(
              onPressed: _confirmPasswordOnSubmit,
              child: Text("1026@global".tr),
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
        ]),
      ),
    ).show();
  }

  void _confirmPasswordOnSubmit() {
    if (_formController.currentState!.validate()) {
      _start(_passwordController.text);
    }
  }

  void _defaultPasswordOnPressed() {
    _start();
  }

  void _start([String? password]) {
    Get.back();

    awesomeDialog(
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      body: Column(children: [
        Text("1015@settings".tr, textAlign: TextAlign.center),
        verticalSpace(AppDecoration.spaceMedium),
        Obx(() {
          return CircularProgressValueIndicator(
            _walletController.progressValue,
          );
        }),
        verticalSpace(AppDecoration.spaceMedium),
      ]),
    ).show();

    _backupOperation.run(
      callback: () => _backupCallback(password),
      closeScreenWhenError: true,
    );
  }

  Future<bool> _backupCallback(String? password) async {
    final String outputPath = await _walletController.backup(
      directory: _directory!,
      password: password,
    );

    _onCompleted(outputPath);

    return true;
  }

  void _onCompleted(String outputPath) {
    Get.back();

    final TextTheme textTheme = Theme.of(Get.context!).textTheme;

    awesomeDialog(
      dialogType: DialogType.success,
      body: Column(children: [
        Center(
          child: Text(
            "1021@global".tr,
            style: textTheme.bodyMedium!.copyWith(color: AppColors.green),
          ),
        ),
        verticalSpace(AppDecoration.spaceMedium),
        Text("1016@settings".tr),
        verticalSpace(AppDecoration.spaceSmall),
        Text(
          outputPath,
          style: textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
        verticalSpace(AppDecoration.spaceMedium),
        WarningText(text: "1019@settings".tr, style: textTheme.labelSmall),
        verticalSpace(AppDecoration.spaceMedium),
      ]),
    ).show();
  }
}
