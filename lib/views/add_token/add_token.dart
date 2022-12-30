import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/add_token/add_token.dart';
import '../../controllers/wallet/wallet.dart';
import '../../models/token.dart';
import '../../utils/constants.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/item_logo.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';
import '../widgets/warning.dart';

class AddTokenView extends StatefulWidget {
  const AddTokenView({super.key});

  @override
  State<AddTokenView> createState() => _AddTokenViewState();
}

class _AddTokenViewState extends State<AddTokenView> {
  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _contractController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();
  final AddTokenController _addTokenController = Get.put(AddTokenController());
  final OperationNotifier _searchOperation = OperationNotifier(
    id: "0xbFbA1D5e",
  );
  final OperationNotifier _addTokenOperation = OperationNotifier(
    id: "0xd08A50Ae",
  );

  @override
  void dispose() {
    _addTokenController.dispose();
    _contractController.dispose();
    super.dispose();
  }

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
          Text(
            "1007@wallet".tr,
            softWrap: false,
            style: textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          WarningText(text: "1000@addToken".tr, style: textTheme.labelSmall),
          verticalSpace(),
          CustomTextFormField(
            controller: _contractController,
            placeholderText: "1001@addToken".tr,
            maxLength: 42,
            keyboardType: TextInputType.name,
            onChanged: _contractOnChanged,
            inputFormatters: [
              FilteringTextInputFormatter.allow(AppRegExp.address),
            ],
            validator: (text) {
              if (text != null && _walletController.tokenExists(text)) {
                return "1018@global".tr;
              }
              return null;
            },
          ),
          verticalSpace(),
          const Divider(),
          verticalSpace(AppDecoration.spaceMedium),
          Obx(() {
            final TokenItemModel? token = _addTokenController.token;

            if (_addTokenController.isSearching) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (token != null) {
              return ListTile(
                minVerticalPadding: 20.0,
                leading: ItemLogo(imageURL: token.imageURL),
                title: Text(
                  token.name,
                  softWrap: false,
                  style: textTheme.bodyMedium!.copyWith(
                    fontFamily: AppFonts.medium,
                  ),
                ),
                subtitle: Text(
                  token.balanceAsCurrency,
                  softWrap: false,
                  style: textTheme.labelSmall,
                ),
                trailing: IconButton(
                  onPressed: () => _addTokenOnPressed(token),
                  tooltip: "1007@wallet".tr,
                  icon: const Icon(LineIcons.plus),
                ),
              );
            }

            return zeroSpace();
          })
        ],
      ),
    );
  }

  void _contractOnChanged(String text) {
    if (_formController.currentState!.validate()) {
      _searchOperation.run(
        callback: () => _addTokenController.search(text),
        invalidMessage: "1002@addToken".tr,
      );
    }
  }

  void _addTokenOnPressed(TokenItemModel token) {
    _addTokenOperation.run(
      callback: () => _walletController.addToken(token).then((_) => true),
      title: token.name,
      validMessage: "1003@addToken".tr,
      closeScreenWhenValid: true,
    );
  }
}
