import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/network/network.dart';
import '../../utils/constants.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';
import '../widgets/warning.dart';

class AddNetworkBody extends StatelessWidget {
  AddNetworkBody({super.key});

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rpcController = TextEditingController();
  final TextEditingController _chainIDController = TextEditingController();
  final TextEditingController _symbolController = TextEditingController();
  final TextEditingController _explorerController = TextEditingController();
  final NetworkController _networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
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
            "1000@addNetwork".tr,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          WarningText(text: "1001@addNetwork".tr),
          verticalSpace(AppDecoration.spaceMedium),
          CustomTextFormField(
            controller: _nameController,
            placeholderText: "1002@addNetwork".tr,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(AppRegExp.letters),
            ],
            validator: (text) {
              if (text != null &&
                  _networkController.networkExists(
                    name: text,
                    rpc: _rpcController.text,
                  )) return "1018@global".tr;

              return null;
            },
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          CustomTextFormField(
            controller: _rpcController,
            placeholderText: "1003@addNetwork".tr,
            maxLength: 100,
            keyboardType: TextInputType.url,
            inputFormatters: [
              FilteringTextInputFormatter.allow(AppRegExp.lettersWithoutSpace),
            ],
            validator: (text) {
              if (text != null && !AppRegExp.url.hasMatch(text)) {
                return "1024@global".tr;
              }
              return null;
            },
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          CustomTextFormField(
            controller: _chainIDController,
            placeholderText: "1004@addNetwork".tr,
            maxLength: 6,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          CustomTextFormField(
            controller: _symbolController,
            placeholderText: "1005@addNetwork".tr,
            maxLength: 20,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(AppRegExp.uppercase),
            ],
            onEditingComplete: _onSubmit,
          ),
          verticalSpace(),
          CustomTextFormField(
            controller: _explorerController,
            placeholderText: "1006@addNetwork".tr,
            maxLength: 100,
            keyboardType: TextInputType.url,
            inputFormatters: [
              FilteringTextInputFormatter.allow(AppRegExp.lettersWithoutSpace),
            ],
            validator: (text) {
              if (text != null && !AppRegExp.url.hasMatch(text)) {
                return "1024@global".tr;
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
                child: Text("1007@addNetwork".tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formController.currentState!.validate()) {
      _addNetwork();
    }
  }

  void _addNetwork() {
    final OperationNotifier operation = OperationNotifier(
      title: "1007@addNetwork".tr,
    );

    _networkController
        .addNew(
      name: _nameController.text,
      rpc: _rpcController.text,
      chainID: int.parse(_chainIDController.text),
      symbol: _symbolController.text,
      explorer: _explorerController.text,
    )
        .then((isValid) {
      isValid
          ? operation.valid("1008@addNetwork".tr)
          : operation.invalid("1009@addNetwork".tr);
      operation.notify(backScreen: isValid);
    }).catchError((error) {
      operation.error(error.toString());
      operation.notify(title: "0xA4d38F81");
    });
  }
}
