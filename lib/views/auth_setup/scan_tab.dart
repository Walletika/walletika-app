import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../controllers/auth_setup/auth_setup.dart';
import '../../controllers/tabs/tabs.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/pin_field.dart';
import '../widgets/spacer.dart';

class AuthScanTabView extends StatelessWidget {
  AuthScanTabView({required this.tabController, super.key});

  final TabController tabController;
  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _pinputController = TextEditingController();
  final TabsController _tabsController = Get.find<TabsController>();
  final AuthSetupController _authSetupController =
      Get.find<AuthSetupController>();

  @override
  Widget build(BuildContext context) {
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
                  "1009@authSetup".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          verticalSpace(),
          Text(
            "1010@authSetup".tr,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          verticalSpace(),
          Center(
            child: QrImage(
              data: _authSetupController.otpKeyFormat,
              size: 150.0,
              padding: const EdgeInsets.all(AppDecoration.paddingMedium),
              foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
              version: QrVersions.auto,
              gapless: false,
            ),
          ),
          verticalSpace(),
          Text(
            "1011@authSetup".tr,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          TextAddress(_authSetupController.otpKey, height: 30.0),
          verticalSpace(AppDecoration.spaceMedium),
          const Divider(),
          verticalSpace(AppDecoration.spaceMedium),
          Text(
            "1012@authSetup".tr,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          verticalSpace(),
          Text(
            "1013@authSetup".tr,
            style: Theme.of(context).textTheme.labelMedium,
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
                onPressed: _onSubmit,
                child: Text("1026@global".tr),
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
      _confirm();
    }
  }

  void _confirm() {
    final OperationNotifier operation = OperationNotifier(
      title: _authSetupController.username,
    );

    _authSetupController.confirmation(_pinputController.text).then((isValid) {
      _pinputController.clear();
      if (isValid) {
        tabController.animateTo(_tabsController.toNextTab());
      } else {
        operation.invalid("1003@auth".tr);
        operation.notify();
      }
    }).catchError((error) {
      _pinputController.clear();
      operation.error(error.toString());
      operation.notify(title: "0xFA8BD5Ec");
    });
  }
}
