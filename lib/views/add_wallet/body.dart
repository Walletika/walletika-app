import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet_manager.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/custom_text_field.dart';
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
                verticalSpace(AppDecoration.paddingMedium),
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
                verticalSpace(AppDecoration.paddingMedium),
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
                verticalSpace(AppDecoration.paddingMedium),
                Text(
                  "1003@AddWallet".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(),
                PasswordFormField(
                  controller: _recoveryPassController,
                  placeholderText: "1013@global".tr,
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
                verticalSpace(AppDecoration.paddingMedium),
                Column(
                  children: [
                    SizedBox(
                      width: AppDecoration.widgetWidth,
                      height: AppDecoration.buttonHeightLarge,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formController.currentState!.validate()) {}
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
}
