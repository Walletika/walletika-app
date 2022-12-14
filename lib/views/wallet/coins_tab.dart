import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet/wallet.dart';
import '../../models/token.dart';
import '../../utils/constants.dart';
import '../widgets/item_logo.dart';
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
            onTap: () {},
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
                  '≈${token.balanceInFiatAsCurrency}',
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
}
