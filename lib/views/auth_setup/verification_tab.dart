import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/auth_setup/auth_setup.dart';
import '../../controllers/tabs/tabs.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/password_field.dart';
import '../widgets/spacer.dart';

class AuthVerificationTabView extends StatelessWidget {
  AuthVerificationTabView({required this.tabController, super.key});

  final TabController tabController;
  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _securityPassController = TextEditingController();
  final TabsController _tabsController = Get.find<TabsController>(
    tag: AppPages.authSetup,
  );
  final AuthSetupController _authSetupController =
      Get.find<AuthSetupController>();
  final OperationNotifier _verifyOperation = OperationNotifier(
    id: "0xBECEb73F",
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
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              IconButton(
                onPressed: _backOnPressed,
                icon: const Icon(LineIcons.angleLeft),
              ),
              Center(
                child: Text(
                  "1007@authSetup".tr,
                  style: textTheme.titleSmall,
                ),
              ),
            ],
          ),
          Text(
            "1008@authSetup".tr,
            style: textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text(
            _authSetupController.username,
            style: textTheme.bodyLarge!.copyWith(fontFamily: AppFonts.bold),
            textAlign: TextAlign.center,
          ),
          TextAddress(_authSetupController.address),
          verticalSpace(AppDecoration.spaceMedium),
          PasswordFormField(
            controller: _passwordController,
            placeholderText: "1011@global".tr,
            enableStrengthBar: false,
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          PasswordFormField(
            controller: _securityPassController,
            placeholderText: "1013@global".tr,
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
                child: Text("1028@global".tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _backOnPressed() {
    tabController.animateTo(_tabsController.toPreviousTab());
  }

  void _onSubmit() {
    if (_formController.currentState!.validate()) {
      _verifyOperation.run(
        callback: () => _authSetupController.verification(
          password: _passwordController.text,
          securityPassword: _securityPassController.text,
        ),
        invalidMessage: "1003@login".tr,
        onValid: () => tabController.animateTo(_tabsController.toNextTab()),
        onInvalid: _fieldsClear,
        onError: _fieldsClear,
      );
    }
  }

  void _fieldsClear() {
    _passwordController.clear();
    _securityPassController.clear();
  }
}
