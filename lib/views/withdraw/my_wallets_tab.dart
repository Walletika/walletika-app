import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet/wallet.dart';
import '../../models/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/empty_page.dart';
import '../widgets/wallet_item.dart';

class MyWalletsTabView extends StatelessWidget {
  MyWalletsTabView(this.toAddressController, {super.key});

  final TextEditingController toAddressController;
  final WalletController _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    final List<WalletItemModel> wallets = _walletController.wallets
        .where((wallet) => wallet != _walletController.currentWallet)
        .toList();

    if (wallets.isEmpty) {
      return EmptyPage(
        illustrationPath: AppImages.emptyIllustrations,
        title: "1004@withdraw".tr,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: AppDecoration.spaceLarge),
      separatorBuilder: (context, index) => const Divider(
        indent: AppDecoration.dividerPadding,
        endIndent: AppDecoration.dividerPadding,
      ),
      itemCount: wallets.length,
      itemBuilder: (context, index) {
        final WalletItemModel wallet = wallets[index];

        return WalletItem(
          onTap: () => _walletOnTap(wallet),
          username: wallet.username,
          address: wallet.address,
        );
      },
    );
  }

  void _walletOnTap(WalletItemModel wallet) {
    if (toAddressController.text == wallet.address) return;

    toAddressController.text = wallet.address;
  }
}
