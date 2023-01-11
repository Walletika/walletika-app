import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transaction/transaction.dart';
import '../../models/transaction.dart';
import '../../utils/constants.dart';
import '../../utils/pretty_json.dart';
import '../widgets/custom_selectable_text.dart';
import '../widgets/dialog.dart';
import '../widgets/spacer.dart';

class TransactionDetailsView {
  final TransactionController _transactionController =
      Get.find<TransactionController>();

  void detailsOnPressed() {
    final TextTheme textTheme = Theme.of(Get.context!).textTheme;

    TransactionDetailsModel txDetails =
        _transactionController.transactionDetails;

    awesomeDialog(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "1006@transaction".tr,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text("1007@transaction".tr, style: textTheme.bodySmall),
          verticalSpace(AppDecoration.spaceSmall),
          CustomSelectableText(
            txDetails.tx['functionType'],
            style: textTheme.labelSmall!.copyWith(
              fontSize: AppFonts.smallestSize,
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text("1008@transaction".tr, style: textTheme.bodySmall),
          verticalSpace(AppDecoration.spaceSmall),
          CustomSelectableText(
            txDetails.tx['from'],
            style: textTheme.labelSmall!.copyWith(
              fontSize: AppFonts.smallestSize,
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text("1009@transaction".tr, style: textTheme.bodySmall),
          verticalSpace(AppDecoration.spaceSmall),
          CustomSelectableText(
            txDetails.tx['to'],
            style: textTheme.labelSmall!.copyWith(
              fontSize: AppFonts.smallestSize,
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text("1010@transaction".tr, style: textTheme.bodySmall),
          verticalSpace(AppDecoration.spaceSmall),
          CustomSelectableText(
            txDetails.tx['data'],
            style: textTheme.labelSmall!.copyWith(
              fontSize: AppFonts.smallestSize,
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text("1011@transaction".tr, style: textTheme.bodySmall),
          verticalSpace(AppDecoration.spaceSmall),
          CustomSelectableText(
            prettyJson(txDetails.tx),
            style: textTheme.labelSmall!.copyWith(
              fontSize: AppFonts.smallestSize,
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text("1012@transaction".tr, style: textTheme.bodySmall),
          verticalSpace(AppDecoration.spaceSmall),
          CustomSelectableText(
            prettyJson(txDetails.args),
            style: textTheme.labelSmall!.copyWith(
              fontSize: AppFonts.smallestSize,
            ),
          ),
          verticalSpace(AppDecoration.spaceMedium),
          Text("1013@transaction".tr, style: textTheme.bodySmall),
          verticalSpace(AppDecoration.spaceSmall),
          CustomSelectableText(
            prettyJson(txDetails.abi),
            style: textTheme.labelSmall!.copyWith(
              fontSize: AppFonts.smallestSize,
            ),
          ),
        ],
      ),
    ).show();
  }
}
