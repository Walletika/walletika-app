import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/dialog.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';

class AccountDetailsBody extends StatelessWidget {
  AccountDetailsBody({super.key});

  final WalletController _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDecoration.paddingBig),
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
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        TextAddress(
          _walletController.currentWallet!.address,
          height: 30.0,
        ),
        verticalSpace(),
        const Divider(
          indent: AppDecoration.dividerPadding,
          endIndent: AppDecoration.dividerPadding,
        ),
        verticalSpace(AppDecoration.spaceMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              LineIcons.exclamationTriangle,
              color: Colors.orange,
              size: 40.0,
            ),
            horizontalSpace(),
            Flexible(
              child: SizedBox(
                width: AppDecoration.widgetWidth,
                child: Text(
                  "1000@accountDetails".tr,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(AppDecoration.spaceMedium),
        Center(
          child: SizedBox(
            width: AppDecoration.widgetWidth,
            height: AppDecoration.buttonHeightLarge,
            child: ElevatedButton(
              onPressed: _onPrivateKeyClicked,
              child: Text("1001@accountDetails".tr),
            ),
          ),
        ),
      ],
    );
  }

  void _onPrivateKeyClicked() {
    final OperationNotifier operation = OperationNotifier(
      title: "1032@global".tr,
    );

    if (_walletController.currentWallet!.isLogged) {
      Get.toNamed(AppPages.auth, arguments: _authValidator);
    } else {
      operation.invalid("1033@global".tr);
      operation.notify();
    }
  }

  Future<bool> _authValidator(String otpCode) async {
    final String? key = await _walletController.getPrivateKey(otpCode);

    if (key == null) return false;

    Get.back();

    awesomeDialog(
      context: Get.context!,
      dialogType: DialogType.success,
      body: Padding(
        padding: const EdgeInsets.only(left: AppDecoration.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "1034@global".tr,
              style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    fontFamily: AppFonts.medium,
                    color: AppColors.green,
                  ),
            ),
            verticalSpace(AppDecoration.spaceMedium),
            Row(
              children: [
                const Icon(
                  LineIcons.exclamationTriangle,
                  color: Colors.orange,
                  size: 40.0,
                ),
                horizontalSpace(),
                Flexible(
                  child: SizedBox(
                    width: AppDecoration.widgetWidth,
                    child: Text(
                      "1000@accountDetails".tr,
                      style: Theme.of(Get.context!).textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(),
            TextAddress(key, width: AppDecoration.widgetWidth, height: 30.0),
          ],
        ),
      ),
      btnOkText: "1022@global".tr,
    ).show();

    return true;
  }
}
