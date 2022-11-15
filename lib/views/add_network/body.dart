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
              padding: const EdgeInsets.all(AppDecoration.paddingMedium),
              cacheExtent: 1000,
              children: [
                Text(
                  "1000@AddNetwork".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(),
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
                          "1001@AddNetwork".tr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(),
                CustomTextFormField(
                  controller: _nameController,
                  placeholderText: "1002@AddNetwork".tr,
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
                ),
                verticalSpace(AppDecoration.spaceSmall),
                CustomTextFormField(
                  controller: _rpcController,
                  placeholderText: "1003@AddNetwork".tr,
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
                ),
                verticalSpace(AppDecoration.spaceSmall),
                CustomTextFormField(
                  controller: _chainIDController,
                  placeholderText: "1004@AddNetwork".tr,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                verticalSpace(AppDecoration.spaceSmall),
                CustomTextFormField(
                  controller: _symbolController,
                  placeholderText: "1005@AddNetwork".tr,
                  maxLength: 20,
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(AppRegExp.uppercase),
                  ],
                ),
                verticalSpace(AppDecoration.spaceSmall),
                CustomTextFormField(
                  controller: _explorerController,
                  placeholderText: "1006@AddNetwork".tr,
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
                ),
                verticalSpace(),
                Center(
                  child: SizedBox(
                    width: AppDecoration.widgetWidth,
                    height: AppDecoration.buttonHeightLarge,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formController.currentState!.validate()) {
                          _onAddNew();
                        }
                      },
                      child: Text("1007@AddNetwork".tr),
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

  void _onAddNew() {
    final OperationNotifier operation = OperationNotifier(
      title: "1007@AddNetwork".tr,
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
          ? operation.valid("1008@AddNetwork".tr)
          : operation.invalid("1009@AddNetwork".tr);
      operation.notify(backScreen: isValid);
    }).catchError((error) {
      operation.error(error.toString());
      operation.notify();
    });
  }
}
