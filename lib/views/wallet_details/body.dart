import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/dialog.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';
import '../widgets/warning.dart';

class WalletDetailsBody extends StatelessWidget {
  WalletDetailsBody({super.key});

  final WalletController _walletController = Get.find<WalletController>();
  final OperationNotifier _privateKeyOperation = OperationNotifier(id: '');

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDecoration.paddingMedium,
        vertical: AppDecoration.paddingBig,
      ),
      children: [
        Text(
          "1006@wallet".tr,
          softWrap: false,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        verticalSpace(),
        Center(
          child: QrImage(
            data: _walletController.currentWallet!.address,
            size: 150.0,
            padding: const EdgeInsets.all(AppDecoration.paddingMedium),
            foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
            version: QrVersions.auto,
            gapless: false,
          ),
        ),
        verticalSpace(),
        Text(
          _walletController.currentWallet!.username,
          softWrap: false,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        TextAddress(_walletController.currentWallet!.address),
        verticalSpace(AppDecoration.spaceMedium),
        const Divider(
          indent: AppDecoration.dividerPadding,
          endIndent: AppDecoration.dividerPadding,
        ),
        verticalSpace(AppDecoration.spaceMedium),
        WarningText(text: "1000@walletDetails".tr),
        verticalSpace(AppDecoration.spaceMedium),
        Center(
          child: SizedBox(
            width: AppDecoration.widgetWidth,
            height: AppDecoration.buttonHeightLarge,
            child: ElevatedButton(
              onPressed: _privateKeyOnPressed,
              child: Text("1001@walletDetails".tr),
            ),
          ),
        ),
      ],
    );
  }

  void _privateKeyOnPressed() {
    _privateKeyOperation.run(
      callback: () async => _walletController.currentWallet!.isLogged,
      title: "1032@global".tr,
      invalidMessage: "1033@global".tr,
      onValid: () => Get.toNamed(AppPages.auth, arguments: _authValidator),
    );
  }

  Future<bool> _authValidator(String otpCode) async {
    final String? key = await _walletController.getPrivateKey(otpCode);

    if (key == null) return false;

    Get.back();

    awesomeDialog(
      dialogType: DialogType.success,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDecoration.padding),
        child: Column(
          children: [
            Text(
              "1034@global".tr,
              style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    fontFamily: AppFonts.medium,
                    color: AppColors.green,
                  ),
            ),
            verticalSpace(AppDecoration.spaceMedium),
            WarningText(text: "1000@walletDetails".tr),
            verticalSpace(AppDecoration.spaceMedium),
            Text(
              "1002@walletDetails".tr,
              style: Theme.of(Get.context!).textTheme.titleSmall,
            ),
            TextAddress(key, width: AppDecoration.widgetWidth),
            verticalSpace(),
          ],
        ),
      ),
      btnOkText: "1022@global".tr,
    ).show();

    return true;
  }
}
