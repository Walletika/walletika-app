import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/addresses_book/addresses_book.dart';
import '../../utils/constants.dart';
import '../widgets/address_field.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/dialog.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';

class AddAddressView {
  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final AddressesBookController _addressesBookController =
      Get.find<AddressesBookController>();
  final OperationNotifier _addAddressOperation = OperationNotifier(
    id: "0xA750Fff7",
  );

  void addAddressOnPressed() {
    awesomeDialog(
      onDismissCallback: (_) {
        _usernameController.clear();
        _addressController.clear();
      },
      body: Form(
        key: _formController,
        child: Column(children: [
          Text("1011@withdraw".tr, textAlign: TextAlign.center),
          verticalSpace(AppDecoration.spaceMedium),
          CustomTextFormField(
            controller: _usernameController,
            placeholderText: "1010@global".tr,
            keyboardType: TextInputType.name,
            maxLength: 30,
            inputFormatters: [
              FilteringTextInputFormatter.allow(AppRegExp.letters),
            ],
            validator: (text) {
              if (text != null &&
                  _addressesBookController.usernameExists(text)) {
                return "1018@global".tr;
              }

              return null;
            },
            onEditingComplete: _addAddressOnSubmit,
          ),
          verticalSpace(),
          AddressFormField(
            controller: _addressController,
            placeholderText: "1043@global".tr,
            validator: (text) {
              if (text != null &&
                  _addressesBookController.addressExists(text)) {
                return "1018@global".tr;
              }

              return null;
            },
            onEditingComplete: _addAddressOnSubmit,
          ),
          verticalSpace(),
          SizedBox(
            width: AppDecoration.widgetWidth,
            height: AppDecoration.buttonHeightLarge,
            child: ElevatedButton(
              onPressed: _addAddressOnSubmit,
              child: Text("1014@withdraw".tr),
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
        ]),
      ),
    ).show();
  }

  void _addAddressOnSubmit() {
    if (_formController.currentState!.validate()) {
      _addAddressOperation.run(
        callback: () => _addressesBookController.addNew(
          username: _usernameController.text,
          address: _addressController.text,
        ),
        validMessage: "1012@withdraw".tr,
        invalidMessage: "1013@withdraw".tr,
        closeScreenWhenValid: true,
        closeScreenWhenError: true,
      );
    }
  }
}
