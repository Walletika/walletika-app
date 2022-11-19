import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet_manager.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
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
              padding: const EdgeInsets.all(AppDecoration.paddingBig),
              cacheExtent: 1000,
              children: [
                Text(
                  "1000@AddWallet".tr,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(AppDecoration.spaceBig),
                Center(
                  child: SizedBox(
                    width: AppDecoration.widgetWidth,
                    child: Text("1001@AddWallet".tr),
                  ),
                ),
                verticalSpace(),
                CustomTextFormField(
                  controller: _usernameController,
                  placeholderText: "1010@global".tr,
                  prefixIcon: const Icon(LineIcons.user),
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      AppRegExp.lettersWithoutSpace,
                    ),
                  ],
                  validator: (text) {
                    if (text != null &&
                        _walletManagerController.usernameExists(text)) {
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
                    child: Text("1002@AddWallet".tr),
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
                    child: Text("1003@AddWallet".tr),
                  ),
                ),
                verticalSpace(),
                PasswordFormField(
                  controller: _recoveryPassController,
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
                  controller: _confirmRPassController,
                  placeholderText: "1014@global".tr,
                  enableStrengthBar: false,
                  validator: (text) {
                    if (text != null && text != _recoveryPassController.text) {
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
                      child: Text("1004@AddWallet".tr),
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

  void _onSubmit() {
    if (_formController.currentState!.validate()) {
      _onAddNew();
    }
  }

  void _onAddNew() {
    final OperationNotifier operation = OperationNotifier(
      title: "1004@AddWallet".tr,
    );

    _walletManagerController
        .addNew(
      username: _usernameController.text,
      password: _passwordController.text,
      recoveryPassword: _recoveryPassController.text,
    )
        .then((isValid) {
      if (isValid) {
        Get.back();

        final BuildContext context = Get.context!;

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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: AppFonts.medium,
                          color: AppColors.green,
                        ),
                  ),
                ),
                verticalSpace(AppDecoration.spaceMedium),
                Text(
                  "1005@AddWallet".tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.red,
                      ),
                ),
                verticalSpace(),
                Text(
                  "1006@AddWallet".tr,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                verticalSpace(AppDecoration.spaceSmall),
                Text(
                  "1007@AddWallet".tr,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                verticalSpace(AppDecoration.spaceSmall),
                Text(
                  "1008@AddWallet".tr,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                verticalSpace(AppDecoration.spaceSmall),
                Text(
                  "1009@AddWallet".tr,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                verticalSpace(AppDecoration.spaceSmall),
                Text(
                  "1010@AddWallet".tr,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                verticalSpace(),
              ],
            ),
          ),
        ).show();
      } else {
        operation.invalid("1011@AddWallet".tr);
        operation.notify();
      }
    }).catchError((error) {
      operation.error(error.toString());
      operation.notify(title: "0x3045C0bA");
    });
  }
}
