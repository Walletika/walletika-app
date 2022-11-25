import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/pin_field.dart';
import '../widgets/spacer.dart';

class AuthBody extends StatelessWidget {
  AuthBody({super.key});

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _pinputController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();
  final Future<bool> Function(String otpCode) _validator = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ContainerWithShadow(),
        Expanded(
          child: Form(
            key: _formController,
            child: ListView(
              padding: const EdgeInsets.all(AppDecoration.paddingBig),
              children: [
                Image.asset(
                  AppImages.authIllustrations,
                  width: 100.0,
                  height: 100.0,
                  filterQuality: FilterQuality.medium,
                  isAntiAlias: true,
                ),
                verticalSpace(),
                Text(
                  "${_walletController.currentWallet.username}\n${"1000@auth".tr}",
                  softWrap: false,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(),
                Text(
                  "1001@auth".tr,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(AppDecoration.spaceMedium),
                PinputFormField(
                  controller: _pinputController,
                  onCompleted: (text) => _onConfirm(),
                ),
                Center(
                  child: SizedBox(
                    width: AppDecoration.widgetWidth,
                    height: AppDecoration.buttonHeightLarge,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formController.currentState!.validate()) {
                          _onConfirm();
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
          ),
        ),
      ],
    );
  }

  void _onConfirm() {
    final OperationNotifier operation = OperationNotifier(
      title: _walletController.currentWallet.username,
    );

    _validator(_pinputController.text).then((isValid) {
      if (!isValid) {
        _pinputController.clear();
        operation.invalid("1003@auth".tr);
        operation.notify();
      }
    }).catchError((error) {
      _pinputController.clear();
      operation.error(error.toString());
      operation.notify(title: "0x513bD3c4");
    });
  }
}
