import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/pin_field.dart';
import '../widgets/spacer.dart';

class AuthBody extends StatelessWidget {
  AuthBody({super.key});

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _pinputController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();
  final Future<bool> Function(String otpCode) _validator = Get.arguments;
  final OperationNotifier _confirmOperation = OperationNotifier(
    id: "0x513bD3c4",
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formController,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDecoration.paddingMedium,
          vertical: AppDecoration.paddingBig,
        ),
        children: [
          Image.asset(
            AppImages.authIllustrations,
            width: 100.0,
            height: 100.0,
            filterQuality: FilterQuality.medium,
            isAntiAlias: true,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text(
            _walletController.currentWallet!.username,
            softWrap: false,
            style: textTheme.bodyLarge!.copyWith(fontFamily: AppFonts.bold),
            textAlign: TextAlign.center,
          ),
          verticalSpace(),
          Text(
            "1000@auth".tr,
            softWrap: false,
            style: textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceSmall),
          Text(
            "1001@auth".tr,
            style: textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          PinputFormField(
            controller: _pinputController,
            onCompleted: (text) => _onSubmit(),
          ),
          Center(
            child: SizedBox(
              width: AppDecoration.widgetWidth,
              height: AppDecoration.buttonHeightLarge,
              child: ElevatedButton(
                onPressed: () {
                  if (_formController.currentState!.validate()) {
                    _onSubmit();
                  }
                },
                child: Text("1026@global".tr),
              ),
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Center(
            child: SizedBox(
              child: TextButton(
                onPressed: () => Get.offNamed(AppPages.authSetup),
                child: Text("1002@auth".tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formController.currentState!.validate()) {
      _confirmOperation.run(
        callback: () => _validator(_pinputController.text),
        invalidMessage: "1003@auth".tr,
        onInvalid: _pinputController.clear,
        onError: _pinputController.clear,
      );
    }
  }
}
