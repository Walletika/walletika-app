import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet/wallet_manager.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/container.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/password_field.dart';
import '../widgets/spacer.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final WalletManagerController _walletManagerController =
      Get.find<WalletManagerController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        const ContainerWithShadow(),
        // List view
        Expanded(
          child: Form(
            key: _formController,
            child: ListView(
              padding: const EdgeInsets.all(AppDecoration.paddingMedium),
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 100.0,
                  height: 100.0,
                  filterQuality: FilterQuality.medium,
                  isAntiAlias: true,
                ),
                verticalSpace(),
                Text(
                  _walletManagerController.currentWallet.username,
                  softWrap: false,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(AppDecoration.spaceSmall),
                Center(
                  child: TextAddress(
                    _walletManagerController.currentWallet.address,
                    width: AppDecoration.widgetWidth,
                    height: 30.0,
                  ),
                ),
                verticalSpace(),
                PasswordFormField(
                  controller: _passwordController,
                  placeholderText: "1011@global".tr,
                  enableStrengthBar: false,
                ),
                verticalSpace(),
                Column(
                  children: [
                    SizedBox(
                      width: AppDecoration.widgetWidth,
                      height: AppDecoration.buttonHeightLarge,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formController.currentState!.validate()) {
                            _onLogin();
                          }
                        },
                        child: Text("1000@login".tr),
                      ),
                    ),
                    verticalSpace(AppDecoration.spaceMedium),
                    TextButton(
                      onPressed: () {},
                      child: Text("1001@login".tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onLogin() {
    final OperationNotifier operation = OperationNotifier(
      title: _walletManagerController.currentWallet.username,
    );

    _walletManagerController.login(_passwordController.text).then((isValid) {
      if (isValid) {
        operation.valid("1003@login".tr);
      } else {
        operation.invalid("1017@global".tr);
      }
      operation.notify();
    }).catchError((error) {
      operation.error(error.toString());
      operation.notify(title: "1002@login".tr);
    });
  }
}
