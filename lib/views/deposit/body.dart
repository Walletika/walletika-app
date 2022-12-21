import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/network_warning.dart';
import '../widgets/spacer.dart';

class DepositBody extends StatelessWidget {
  DepositBody({super.key});

  final WalletController _walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDecoration.paddingMedium,
        vertical: AppDecoration.paddingBig,
      ),
      children: [
        Text(
          "1001@wallet".tr,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        verticalSpace(AppDecoration.spaceMedium),
        NetworkWarning(
          text: "1002@deposit".tr,
          onTap: () => Get.toNamed(AppPages.network),
        ),
        verticalSpace(AppDecoration.spaceMedium),
        const Divider(
          indent: AppDecoration.dividerPadding,
          endIndent: AppDecoration.dividerPadding,
        ),
        verticalSpace(AppDecoration.spaceMedium),
        Text(
          "1000@deposit".tr,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        verticalSpace(),
        Center(
          child: QrImage(
            data: _walletController.currentWallet!.address,
            size: 150.0,
            padding: const EdgeInsets.all(AppDecoration.paddingMedium),
            foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
            version: QrVersions.auto,
            gapless: false,
          ),
        ),
        verticalSpace(),
        Text(
          "1001@deposit".tr,
          softWrap: false,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        TextAddress(_walletController.currentWallet!.address),
      ],
    );
  }
}
