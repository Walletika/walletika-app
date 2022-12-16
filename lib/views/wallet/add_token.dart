import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/add_token.dart';
import '../../controllers/wallet/wallet.dart';
import '../../models/token.dart';
import '../../utils/constants.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/item_logo.dart';
import '../widgets/spacer.dart';

class AddTokenBottomSheet extends StatefulWidget {
  const AddTokenBottomSheet({super.key});

  @override
  State<AddTokenBottomSheet> createState() => _AddTokenBottomSheetState();
}

class _AddTokenBottomSheetState extends State<AddTokenBottomSheet> {
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
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppDecoration.paddingBig,
          left: AppDecoration.paddingBig,
          right: AppDecoration.paddingBig,
        ),
        child: Column(
          children: [
            Text(
              "1000@addToken".tr,
              softWrap: false,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      "1001@addToken".tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(AppDecoration.spaceMedium),
            CustomTextFormField(
              controller: _contractController,
              placeholderText: "1003@addToken".tr,
              maxLength: 42,
              keyboardType: TextInputType.name,
              onChanged: _onChanged,
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
            Obx(() {
              final TokenItemModel? token = _addTokenController.token;

              if (_addTokenController.isSearching) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (token != null) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ItemLogo(imageURL: token.imageURL),
                    horizontalSpace(),
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            token.name,
                            softWrap: false,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            token.balanceAsCurrency,
                            softWrap: false,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    horizontalSpace(AppDecoration.spaceBig),
                    IconButton(
                      onPressed: () {
                        _walletController.addToken(token);
                        Get.back();
                      },
                      tooltip: "1007@wallet".tr,
                      icon: const Icon(LineIcons.plus),
                    ),
                  ],
                );
              } else if (_contractController.text.isNotEmpty) {
                return Text(
                  "1004@addToken".tr,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                      ),
                  textAlign: TextAlign.center,
                );
              }

              return zeroSpace();
            })
          ],
        ),
      ),
    );
  }

  void _onChanged(String text) {
    if (_formController.currentState!.validate()) {
      _addTokenController.search(text);
    }
  }
}
