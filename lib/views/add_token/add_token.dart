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

  @override
  void dispose() {
    _addTokenController.dispose();
    _contractController.dispose();
    super.dispose();
  }

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
          Text(
            "1007@wallet".tr,
            softWrap: false,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          WarningText(text: "1000@addToken".tr),
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
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Text(
                  token.balanceAsCurrency,
                  softWrap: false,
                  style: Theme.of(context).textTheme.labelMedium,
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
      _search(text);
    }
  }

  void _search(String text) {
    final OperationNotifier operation = OperationNotifier(
      title: "1007@wallet".tr,
    );

    _addTokenController.search(text).then((isValid) {
      if (!isValid) {
        operation.invalid("1002@addToken".tr);
        operation.notify();
      }
    }).catchError((error) {
      operation.error(error.toString());
      operation.notify(title: "0xbFbA1D5e");
    });
  }

  void _addTokenOnPressed(TokenItemModel token) {
    final OperationNotifier operation = OperationNotifier(
      title: token.name,
    );

    _walletController.addToken(token).then((_) {
      operation.valid("1003@addToken".tr);
      operation.notify(backScreen: true);
    }).catchError((error) {
      operation.error(error.toString());
      operation.notify(title: "0xd08A50Ae");
    });
  }
}
