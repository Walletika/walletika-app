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

class CoinsTabView extends StatelessWidget {
  CoinsTabView({super.key});

  final WalletController _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<TokenItemModel> tokens = _walletController.tokens;

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
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(
              token.balanceAsCurrency,
              softWrap: false,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...token.changeIn24h != null
                    ? [
                        Text(
                          token.changeIn24hAsPercentage,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontFamily: AppFonts.medium,
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
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontFamily: AppFonts.medium,
                      ),
                ),
                Text(
                  token.balanceInFiatAsCurrency,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontFamily: AppFonts.medium,
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
            style: textTheme.titleSmall,
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
            onPressed: () => launchURL(token.explorerURL),
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

  void _removeOnPressed(TokenItemModel token) {
    Get.back();

    awesomeDialog(
      dialogType: DialogType.warning,
      title: "1014@wallet".tr,
      desc: "${"1015@wallet".tr} ( ${token.name} )",
      btnOkText: "1007@global".tr,
      btnOkOnPress: () => _removeToken(token),
    ).show();
  }

  void _removeToken(TokenItemModel token) {
    final OperationNotifier operation = OperationNotifier(
      title: token.name,
    );

    _walletController.removeToken(token).then((isValid) {
      isValid
          ? operation.valid("1016@wallet".tr)
          : operation.invalid("1017@wallet".tr);

      operation.notify();
    }).catchError((error) {
      operation.error(error.toString());
      operation.notify(title: "0x5CE297A6");
    });
  }
}
