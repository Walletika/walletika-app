import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/password_field.dart';
import '../widgets/spacer.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Form(
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
            _walletController.currentWallet!.username,
            softWrap: false,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceSmall),
          TextAddress(
            _walletController.currentWallet!.address,
            height: 30.0,
          ),
          verticalSpace(),
          PasswordFormField(
            controller: _passwordController,
            placeholderText: "1011@global".tr,
            enableStrengthBar: false,
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          Center(
            child: SizedBox(
              width: AppDecoration.widgetWidth,
              height: AppDecoration.buttonHeightLarge,
              child: ElevatedButton(
                onPressed: _onSubmit,
                child: Text("1000@login".tr),
              ),
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Center(
            child: TextButton(
              onPressed: () => Get.offNamed(AppPages.wallet),
              child: Text("1001@login".tr),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formController.currentState!.validate()) {
      _login();
    }
  }

  void _login() {
    final OperationNotifier operation = OperationNotifier(
      title: _walletController.currentWallet!.username,
    );

    _walletController.loginValidate(_passwordController.text).then((isValid) {
      if (isValid) {
        Get.offNamed(AppPages.auth, arguments: _authValidator);
      } else {
        _passwordController.clear();
        operation.invalid("1003@login".tr);
        operation.notify();
      }
    }).catchError((error) {
      _passwordController.clear();
      operation.error(error.toString());
      operation.notify(title: "0x6B6fccaf");
    });
  }

  Future<bool> _authValidator(String otpCode) async {
    final isLogged = await _walletController.login(
      password: _passwordController.text,
      otpCode: otpCode,
    );

    if (isLogged) Get.offNamed(AppPages.wallet);

    return isLogged;
  }
}
