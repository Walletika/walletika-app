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

class ImportView {
  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();
  final OperationNotifier _importOperation = OperationNotifier(
    id: "0x90a6cfe1",
  );

  String? _filePath;

  void importOnPressed() {
    if (Get.isSnackbarOpen) return;

    FilePicker.platform
        .pickFiles(
      type: FileType.custom,
      allowedExtensions: ['aes'],
      lockParentWindow: true,
    )
        .then((result) {
      _filePath = result?.paths.first;

      if (_filePath == null) return;

      _start();
    });
  }

  void _start([String? password]) {
    if (password != null) Get.back();

    final TextTheme textTheme = Theme.of(Get.context!).textTheme;

    awesomeDialog(
      showCloseIcon: false,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      body: Column(children: [
        Text(
          "1015@settings".tr,
          style: textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        verticalSpace(AppDecoration.spaceMedium),
        Obx(() {
          return CircularProgressValueIndicator(
            _walletController.progressValue,
          );
        }),
        verticalSpace(AppDecoration.spaceMedium),
      ]),
    ).show();

    _importOperation.run(
      callback: () => _walletController.import(
        path: _filePath!,
        password: password,
      ),
      validMessage: "1017@settings".tr,
      invalidMessage: password == null ? null : "1018@settings".tr,
      closeScreenWhenValid: true,
      closeScreenWhenInvalid: true,
      closeScreenWhenError: true,
      onInvalid: () {
        if (password == null) _specificPasswordOnPressed();
      },
    );
  }

  void _specificPasswordOnPressed() {
    Get.back();

    final TextTheme textTheme = Theme.of(Get.context!).textTheme;

    awesomeDialog(
      onDismissCallback: (_) => _passwordController.clear(),
      body: Form(
        key: _formController,
        child: Column(children: [
          Text(
            "1013@settings".tr,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          PasswordFormField(
            controller: _passwordController,
            placeholderText: "1012@global".tr,
            enableStrengthBar: false,
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
}
