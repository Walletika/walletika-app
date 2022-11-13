import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet_manager.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/dialog.dart';
import '../widgets/password_field.dart';
import '../widgets/spacer.dart';

class AddWalletBody extends StatelessWidget {
  AddWalletBody({super.key});

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _recoveryPassController = TextEditingController();
  final TextEditingController _confirmRPassController = TextEditingController();
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
              cacheExtent: 1000,
              children: [
                Text(
                  "1000@AddWallet".tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(AppDecoration.spaceMedium),
                Text(
                  "1001@AddWallet".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(),
                CustomTextFormField(
                  controller: _usernameController,
                  placeholderText: "1010@global".tr,
                  prefixIcon: const Icon(LineIcons.user),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value != null &&
                        _walletManagerController.usernameExists(value)) {
                      return "1018@global".tr;
                    }
                    return null;
                  },
                ),
                verticalSpace(AppDecoration.spaceMedium),
                Text(
                  "1002@AddWallet".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(),
                PasswordFormField(
                  controller: _passwordController,
                  placeholderText: "1011@global".tr,
                ),
                verticalSpace(),
                PasswordFormField(
                  controller: _confirmPassController,
                  placeholderText: "1012@global".tr,
                  enableStrengthBar: false,
                  validator: (value) {
                    if (value != null && value != _passwordController.text) {
                      return "1017@global".tr;
                    }
                    return null;
                  },
                ),
                verticalSpace(AppDecoration.spaceMedium),
                Text(
                  "1003@AddWallet".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(),
                PasswordFormField(
                  controller: _recoveryPassController,
                  placeholderText: "1013@global".tr,
                  validator: (value) {
                    if (value != null && value == _passwordController.text) {
                      return "1023@global".tr;
                    }
                    return null;
                  },
                ),
                verticalSpace(),
                PasswordFormField(
                  controller: _confirmRPassController,
                  placeholderText: "1014@global".tr,
                  enableStrengthBar: false,
                  validator: (value) {
                    if (value != null &&
                        value != _recoveryPassController.text) {
                      return "1017@global".tr;
                    }
                    return null;
                  },
                ),
                verticalSpace(AppDecoration.spaceMedium),
                Column(
                  children: [
                    SizedBox(
                      width: AppDecoration.widgetWidth,
                      height: AppDecoration.buttonHeightLarge,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formController.currentState!.validate()) {
                            _walletManagerController
                                .addNew(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                  recoveryPassword:
                                      _recoveryPassController.text,
                                )
                                .then((value) => _onSubmit(context, value));
                          }
                        },
                        child: Text("1004@AddWallet".tr),
                      ),
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

  void _onSubmit(BuildContext context, bool isValid) {
    if (!isValid) {
      awesomeDialogError(context: context).show();
      return;
    }

    awesomeDialog(
      context: context,
      dialogType: DialogType.success,
      body: Padding(
        padding: const EdgeInsets.only(left: AppDecoration.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "1021@global".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.green),
              ),
            ),
            verticalSpace(AppDecoration.spaceMedium),
            Text(
              "1005@AddWallet".tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.red,
                  ),
            ),
            verticalSpace(AppDecoration.spaceSmall),
            Text(
              "1006@AddWallet".tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            verticalSpace(AppDecoration.spaceSmall),
            Text(
              "1007@AddWallet".tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            verticalSpace(AppDecoration.spaceSmall),
            Text(
              "1008@AddWallet".tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            verticalSpace(AppDecoration.spaceSmall),
            Text(
              "1009@AddWallet".tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            verticalSpace(AppDecoration.spaceSmall),
            Text(
              "1010@AddWallet".tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      btnCancelText: "1022@global".tr,
    ).show().whenComplete(() {
      Future.delayed(const Duration(milliseconds: 500), Get.back);
    });
  }
}
