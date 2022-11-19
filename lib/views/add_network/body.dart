import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/network/network_manager.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';

class AddNetworkBody extends StatelessWidget {
  AddNetworkBody({super.key});

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rpcController = TextEditingController();
  final TextEditingController _chainIDController = TextEditingController();
  final TextEditingController _symbolController = TextEditingController();
  final TextEditingController _explorerController = TextEditingController();
  final NetworkManagerController _networkManagerController =
      Get.find<NetworkManagerController>();

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
                  "1000@addNetwork".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(AppDecoration.spaceMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      LineIcons.exclamationCircle,
                      color: Colors.orange,
                      size: 40.0,
                    ),
                    horizontalSpace(),
                    Flexible(
                      child: SizedBox(
                        width: AppDecoration.widgetWidth,
                        child: Text(
                          "1001@addNetwork".tr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
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
                        _networkManagerController.networkExists(
                          name: text,
                          rpc: _rpcController.text,
                        )) return "1018@global".tr;

                    return null;
                  },
                  onEditingComplete: _onSubmit,
                ),
                verticalSpace(AppDecoration.spaceSmall),
                CustomTextFormField(
                  controller: _rpcController,
                  placeholderText: "1003@addNetwork".tr,
                  maxLength: 100,
                  keyboardType: TextInputType.url,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      AppRegExp.lettersWithoutSpace,
                    ),
                  ],
                  validator: (text) {
                    if (text != null && !AppRegExp.url.hasMatch(text)) {
                      return "1024@global".tr;
                    }
                    return null;
                  },
                  onEditingComplete: _onSubmit,
                ),
                verticalSpace(AppDecoration.spaceSmall),
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
                verticalSpace(AppDecoration.spaceSmall),
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
                verticalSpace(AppDecoration.spaceSmall),
                CustomTextFormField(
                  controller: _explorerController,
                  placeholderText: "1006@addNetwork".tr,
                  maxLength: 100,
                  keyboardType: TextInputType.url,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      AppRegExp.lettersWithoutSpace,
                    ),
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
      title: "1007@addNetwork".tr,
    );

    _networkManagerController
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
