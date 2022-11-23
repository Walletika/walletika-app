import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../widgets/spacer.dart';

class AuthFourthabView extends StatelessWidget {
  const AuthFourthabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDecoration.paddingMedium),
      child: Column(
        children: [
          Flexible(
            child: Image.asset(
              AppImages.doneIllustrations,
              filterQuality: FilterQuality.medium,
              isAntiAlias: true,
            ),
          ),
          Text(
            "1014@authSetup".tr,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          verticalSpace(),
          Text(
            "1015@authSetup".tr,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.paddingMedium),
          Center(
            child: SizedBox(
              width: AppDecoration.widgetWidth,
              height: AppDecoration.buttonHeightLarge,
              child: ElevatedButton(
                onPressed: Get.back,
                child: Text("1029@global".tr),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
