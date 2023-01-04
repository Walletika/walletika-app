import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet/wallet.dart';
import '../../controllers/withdraw/withdraw.dart';
import '../../models/token.dart';
import '../../utils/constants.dart';
import '../widgets/amount_field.dart';
import '../widgets/item_logo.dart';
import '../widgets/spacer.dart';

class AmountView extends StatelessWidget {
  AmountView({super.key}) {
    _tokenOnChanged(_walletController.tokens.first);
  }

  final GlobalKey<FormState> _formController = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final WalletController _walletController = Get.find<WalletController>();
  final WithdrawController _withdrawController = Get.find<WithdrawController>();

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
          Text("1015@withdraw".tr, textAlign: TextAlign.center),
          verticalSpace(AppDecoration.spaceMedium),
          Center(
            child: Obx(() {
              final List<TokenItemModel> tokens = _walletController.tokens;

              return DropdownButton(
                style: textTheme.bodyMedium,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                borderRadius: BorderRadius.circular(AppDecoration.radius),
                dropdownColor: Theme.of(context).popupMenuTheme.color,
                underline: zeroSpace(),
                value: _withdrawController.token,
                onChanged: _tokenOnChanged,
                items: tokens.map((token) {
                  return DropdownMenuItem(
                    value: token,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDecoration.padding,
                        ),
                        child: ItemLogo(
                          imageURL: token.imageURL,
                          size: AppDecoration.iconSize,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(token.name),
                          Text(
                            token.balanceAsCurrency,
                            style: textTheme.labelSmall,
                          )
                        ],
                      ),
                    ]),
                  );
                }).toList(),
              );
            }),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Obx(() {
            final TokenItemModel token = _withdrawController.token;

            return AmountFormField(
              controller: _amountController,
              showMaxButton: true,
              imageURL: token.imageURL,
              balance: token.balance,
            );
          }),
          verticalSpace(),
          Center(
            child: SizedBox(
              width: AppDecoration.widgetWidth,
              height: AppDecoration.buttonHeightLarge,
              child: ElevatedButton(
                onPressed: _continueOnPressed,
                child: Text("1039@global".tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tokenOnChanged(TokenItemModel? token) {
    _amountController.clear();
    _withdrawController.setToken(token!);
  }

  void _continueOnPressed() {
    if (_formController.currentState!.validate()) {
      _withdrawController.setAmount(_amountController.text);
      Get.back();
    }
  }
}
