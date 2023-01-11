import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transaction/transaction.dart';
import '../../controllers/wallet/wallet.dart';
import '../../models/transaction.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/item_logo.dart';
import '../widgets/network_warning.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';
import 'details.dart';

class TransactionBody extends StatefulWidget {
  const TransactionBody({super.key});

  @override
  State<TransactionBody> createState() => _TransactionBodyState();
}

class _TransactionBodyState extends State<TransactionBody> {
  late Timer _gasUpdateTimer;
  final WalletController _walletController = Get.find<WalletController>();
  final TransactionController _transactionController =
      Get.find<TransactionController>();
  final TransactionDetailsView _transactionDetailsView =
      TransactionDetailsView();
  final OperationNotifier _gasUpdateOperation = OperationNotifier(
    id: "0xf8b592F5",
  );

  @override
  void initState() {
    // Run once initialized
    _timerCallback();

    // Rerun every 30 sec
    _gasUpdateTimer = Timer.periodic(
      const Duration(seconds: 30),
      _timerCallback,
    );

    super.initState();
  }

  @override
  void dispose() {
    _gasUpdateTimer.cancel();
    _transactionController.setPrivateKey(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    TransactionDetailsModel txDetails =
        _transactionController.transactionDetails;

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDecoration.paddingMedium,
        vertical: AppDecoration.paddingBig,
      ),
      children: [
        NetworkWarning(
          text: "1000@transaction".tr,
          onTap: () => Get.offNamed(AppPages.network),
        ),
        verticalSpace(AppDecoration.spaceMedium),
        const Divider(
          indent: AppDecoration.dividerPadding,
          endIndent: AppDecoration.dividerPadding,
        ),
        verticalSpace(AppDecoration.spaceMedium),
        ListTile(
          leading: ItemLogo(imageURL: txDetails.token.imageURL),
          title: Text(
            txDetails.requestName.tr,
            softWrap: false,
            style: textTheme.titleSmall,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txDetails.amountAsCurrency,
                softWrap: false,
                style: textTheme.bodyMedium,
              ),
              ...txDetails.amountInFiat != null
                  ? [
                      Text(
                        txDetails.amountInFiatAsCurrency,
                        softWrap: false,
                        style: textTheme.labelSmall,
                      ),
                    ]
                  : [],
            ],
          ),
          trailing: SizedBox(
            width: 70.0,
            child: OutlinedButton(
              onPressed: _transactionDetailsView.detailsOnPressed,
              child: Text(
                "1044@global".tr,
                style: textTheme.bodySmall!.copyWith(
                  color: AppColors.highlight,
                ),
              ),
            ),
          ),
        ),
        verticalSpace(),
        ListTile(
          title: Text(
            "1001@transaction".tr,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          subtitle: TextAddress(txDetails.toAddress),
        ),
        verticalSpace(),
        Obx(() {
          final bool isGasUpdated = _transactionController.gasUpdated;
          txDetails = _transactionController.transactionDetails;

          return AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: isGasUpdated ? 1.0 : 0,
            child: Container(
              padding: const EdgeInsets.all(AppDecoration.padding),
              decoration: BoxDecoration(
                color: Theme.of(context).popupMenuTheme.color,
                borderRadius: BorderRadius.circular(AppDecoration.radius),
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1002@transaction".tr),
                    horizontalSpace(),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            txDetails.estimatedGasAsCurrency,
                            style: textTheme.labelSmall,
                          ),
                          Text(
                            txDetails.estimatedGasInFiatAsCurrency,
                            style: textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1003@transaction".tr),
                        Text(
                          "1004@transaction".tr,
                          style: textTheme.labelSmall!.copyWith(
                            fontSize: AppFonts.smallestSize,
                          ),
                        ),
                      ],
                    ),
                    horizontalSpace(),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            txDetails.totalAsCurrency,
                            style: textTheme.labelSmall,
                          ),
                          ...txDetails.token != txDetails.coin
                              ? [
                                  Text(
                                    txDetails.amountAsCurrency,
                                    style: textTheme.labelSmall,
                                  ),
                                ]
                              : [],
                          Text(
                            txDetails.totalInFiatAsCurrency,
                            style: textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          );
        }),
        verticalSpace(AppDecoration.spaceMedium),
        Center(
          child: SizedBox(
            width: AppDecoration.widgetWidth,
            height: AppDecoration.buttonHeightLarge,
            child: Obx(() {
              final bool isGasUpdated = _transactionController.gasUpdated;

              return ElevatedButton(
                onPressed:
                    isGasUpdated && _gasUpdateOperation.isValid ? () {} : null,
                child: Text("1026@global".tr),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _timerCallback([Timer? timer]) {
    _gasUpdateOperation.run(
      callback: _gasUpdate,
      invalidMessage: "1005@transaction".tr,
    );
  }

  Future<bool> _gasUpdate() {
    return _walletController.gasUpdate().then<bool>((txDetails) async {
      _transactionController.setGasUpdated(false);

      await Future.delayed(const Duration(milliseconds: 800));

      _transactionController.setTransactionDetails(txDetails);
      _transactionController.setGasUpdated(true);

      if (txDetails.total > txDetails.coin.balance!) {
        throw Exception('Insufficient funds');
      }

      return true;
    }).catchError((error) {
      if (error.toString().contains('Insufficient funds')) return false;
    });
  }
}
