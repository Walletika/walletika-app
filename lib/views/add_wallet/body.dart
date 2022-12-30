import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/dialog.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/password_field.dart';
import '../widgets/spacer.dart';

class AddWalletBody extends StatelessWidget {
  AddWalletBody({super.key});

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _securityPassController = TextEditingController();
  final TextEditingController _confirmSPassController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();
  final OperationNotifier _addWalletOperation = OperationNotifier(
    id: "0x3045C0bA",
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
        cacheExtent: 1000,
        children: [
          Text(
            "1000@addWallet".tr,
            style: textTheme.bodyMedium!.copyWith(fontFamily: AppFonts.medium),
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceBig),
          Center(
            child: SizedBox(
              width: AppDecoration.widgetWidth,
              child: Text("1001@addWallet".tr),
            ),
          ),
          verticalSpace(),
          CustomTextFormField(
            controller: _usernameController,
            placeholderText: "1010@global".tr,
            prefixIcon: const Icon(LineIcons.user),
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(AppRegExp.lettersWithoutSpace),
            ],
            validator: (text) {
              if (text != null && _walletController.usernameExists(text)) {
                return "1018@global".tr;
              }
              return null;
            },
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          Center(
            child: SizedBox(
              width: AppDecoration.widgetWidth,
              child: Text("1002@addWallet".tr),
            ),
          ),
          verticalSpace(),
          PasswordFormField(
            controller: _passwordController,
            placeholderText: "1011@global".tr,
            onEditingComplete: _onSubmit,
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
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          Center(
            child: SizedBox(
              width: AppDecoration.widgetWidth,
              child: Text("1003@addWallet".tr),
            ),
          ),
          verticalSpace(),
          PasswordFormField(
            controller: _securityPassController,
            placeholderText: "1013@global".tr,
            validator: (text) {
              if (text != null && text == _passwordController.text) {
                return "1023@global".tr;
              }
              return null;
            },
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          PasswordFormField(
            controller: _confirmSPassController,
            placeholderText: "1014@global".tr,
            enableStrengthBar: false,
            validator: (text) {
              if (text != null && text != _securityPassController.text) {
                return "1017@global".tr;
              }
              return null;
            },
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          Center(
            child: SizedBox(
              width: AppDecoration.widgetWidth,
              height: AppDecoration.buttonHeightLarge,
              child: ElevatedButton(
                onPressed: _onSubmit,
                child: Text("1004@addWallet".tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formController.currentState!.validate()) {
      _addWalletOperation.run(
        callback: () => _walletController.addNew(
          username: _usernameController.text,
          password: _passwordController.text,
          securityPassword: _securityPassController.text,
        ),
        invalidMessage: "1011@addWallet".tr,
        onValid: _onCompleted,
      );
    }
  }

  void _onCompleted() {
    Get.back();

    final TextTheme textTheme = Theme.of(Get.context!).textTheme;

    awesomeDialog(
      dialogType: DialogType.success,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "1021@global".tr,
              style: textTheme.bodyMedium!.copyWith(color: AppColors.green),
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text(
            "1005@addWallet".tr,
            style: textTheme.bodyMedium!.copyWith(color: Colors.red),
          ),
          verticalSpace(),
          Text("1006@addWallet".tr, style: textTheme.labelSmall),
          verticalSpace(),
          Text("1007@addWallet".tr, style: textTheme.labelSmall),
          verticalSpace(),
          Text("1008@addWallet".tr, style: textTheme.labelSmall),
          verticalSpace(),
          Text("1009@addWallet".tr, style: textTheme.labelSmall),
          verticalSpace(),
          Text("1010@addWallet".tr, style: textTheme.labelSmall),
          verticalSpace(),
        ],
      ),
      btnOkText: "1012@addWallet".tr,
      btnOkOnPress: () => Get.toNamed(AppPages.authSetup),
    ).show();
  }
}
