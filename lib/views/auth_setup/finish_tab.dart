import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../widgets/empty_page.dart';
import '../widgets/spacer.dart';

class AuthFinishTabView extends StatelessWidget {
  const AuthFinishTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      illustrationPath: AppImages.doneIllustrations,
      title: "1014@authSetup".tr,
      desc: "1015@authSetup".tr,
      actions: [
        verticalSpace(AppDecoration.spaceMedium),
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
        verticalSpace(AppDecoration.spaceMedium),
      ],
    );
  }
}
