import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet.dart';
import '../../models/token.dart';
import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import '../widgets/address.dart';
import '../widgets/dialog.dart';
import '../widgets/item_logo.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';

class TokensTabView extends StatelessWidget {
  TokensTabView({super.key});

  final WalletController _walletController = Get.find<WalletController>();
  final OperationNotifier _removeOperation = OperationNotifier(
    id: "0x5CE297A6",
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Obx(() {
      final List<TokenItemModel> tokens = _walletController.tokens;
      final bool visible = _walletController.isBalanceVisible;

      if (tokens.isEmpty) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }

      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          indent: AppDecoration.dividerPadding,
          endIndent: AppDecoration.dividerPadding,
        ),
        itemCount: tokens.length,
        itemBuilder: (context, index) {
          final TokenItemModel token = tokens[index];

          return ListTile(
            minVerticalPadding: 20.0,
            onTap: () => _tokenOnTap(token),
            leading: ItemLogo(imageURL: token.imageURL),
            title: Text(
              token.name,
              softWrap: false,
              style: textTheme.bodyMedium!.copyWith(
                fontFamily: AppFonts.medium,
              ),
            ),
            subtitle: Text(
              visible ? token.balanceAsCurrency : AppDecoration.invisibleText,
              softWrap: false,
              style: textTheme.labelSmall,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...token.changeIn24h != null
                    ? [
                        Text(
                          token.changeIn24hAsPercentage,
                          style: textTheme.bodySmall!.copyWith(
                            fontFamily: AppFonts.medium,
                            fontSize: AppFonts.smallestSize,
                            color: token.changeIn24h!.isNegative
                                ? Colors.red
                                : AppColors.green,
                          ),
                        ),
                        verticalSpace(AppDecoration.spaceSmall),
                      ]
                    : [],
                Text(
                  token.priceAsCurrency,
                  style: textTheme.labelSmall!.copyWith(
                    fontFamily: AppFonts.medium,
                    fontSize: AppFonts.smallestSize,
                  ),
                ),
                Text(
                  visible
                      ? token.balanceInFiatAsCurrency
                      : AppDecoration.invisibleText,
                  style: textTheme.labelSmall!.copyWith(
                    fontFamily: AppFonts.medium,
                    fontSize: AppFonts.smallestSize,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  void _tokenOnTap(TokenItemModel token) {
    final TextTheme textTheme = Theme.of(Get.context!).textTheme;

    awesomeDialog(
      body: Column(
        children: [
          Text(
            "1012@wallet".tr,
            softWrap: false,
            style: textTheme.bodyLarge,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          ItemLogo(imageURL: token.imageURL),
          verticalSpace(),
          Text(
            "${token.name} | ${token.symbol}",
            softWrap: false,
            style: textTheme.titleSmall,
          ),
          verticalSpace(),
          ...token.address != null
              ? [
                  TextAddress(token.address!, width: 200.0),
                  Text(
                    "${"1013@wallet".tr} : ${token.decimals}",
                    style: textTheme.labelSmall,
                  ),
                  verticalSpace(),
                ]
              : [],
          TextButton.icon(
            onPressed: () => _explorerOnPressed(token.explorerURL),
            icon: const Icon(LineIcons.alternateExternalLink),
            label: Text("1008@wallet".tr),
          ),
          ...token.address != null
              ? [
                  TextButton.icon(
                    onPressed: () => _removeOnPressed(token),
                    icon: const Icon(LineIcons.trash),
                    label: Text("1007@global".tr),
                  ),
                ]
              : [],
          verticalSpace(AppDecoration.spaceMedium),
        ],
      ),
    ).show();
  }

  void _explorerOnPressed(String url) {
    Get.back();
    launchURL(url);
  }

  void _removeOnPressed(TokenItemModel token) {
    Get.back();

    awesomeDialog(
      dialogType: DialogType.warning,
      title: "1014@wallet".tr,
      desc: "1015@wallet".tr,
      btnOkText: "1007@global".tr,
      btnOkOnPress: () => _removeToken(token),
    ).show();
  }

  void _removeToken(TokenItemModel token) {
    _removeOperation.run(
      callback: () => _walletController.removeToken(token),
      title: token.name,
      validMessage: "1016@wallet".tr,
      invalidMessage: "1017@wallet".tr,
    );
  }
}
