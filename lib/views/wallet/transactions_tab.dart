import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet.dart';
import '../../models/transaction.dart';
import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import '../widgets/address.dart';
import '../widgets/item_logo.dart';
import '../widgets/spacer.dart';

class TransactionsTabView extends StatelessWidget {
  TransactionsTabView({super.key});

  final WalletController _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<TransactionItemModel> transactions =
          _walletController.transactions;

      if (transactions.isEmpty) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }

      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          indent: AppDecoration.dividerPadding,
          endIndent: AppDecoration.dividerPadding,
        ),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final TransactionItemModel transaction = transactions[index];

          return ListTile(
            minVerticalPadding: 15.0,
            onTap: () {},
            leading: ItemLogo(imageURL: transaction.imageURL),
            title: Text(
              transaction.functionName,
              softWrap: false,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAddress(
                  transaction.txHash,
                  height: 22.0,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                Text(
                  transaction.date.toString().split('.').first,
                  softWrap: false,
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.amountAsCurrency,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontFamily: AppFonts.medium,
                      ),
                ),
                verticalSpace(AppDecoration.spaceSmall),
                Tooltip(
                  message: "1031@global".tr,
                  child: GestureDetector(
                    onTap: () {
                      launchURL(transaction.txHashURL);
                    },
                    child: const Icon(LineIcons.alternateExternalLink),
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
