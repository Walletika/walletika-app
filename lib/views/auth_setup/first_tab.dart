import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_setup/auth_setup.dart';
import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import '../widgets/spacer.dart';

class AuthFirstTabView extends StatelessWidget {
  AuthFirstTabView({required this.tabController, super.key});

  final TabController tabController;
  final AuthSetupController _authSetupController =
      Get.find<AuthSetupController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDecoration.paddingBig),
      children: [
        Text(
          "1003@authSetup".tr,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        verticalSpace(),
        Text(
          "1004@authSetup".tr,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        verticalSpace(AppDecoration.spaceBig),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1005@authSetup".tr,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(),
              Wrap(
                spacing: AppDecoration.space,
                runSpacing: AppDecoration.space,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => launchURL(AppInfo.authGooglePlay),
                      child: Image.asset(
                        AppImages.googlePlayLogo,
                        isAntiAlias: true,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => launchURL(AppInfo.authAppStore),
                      child: Image.asset(
                        AppImages.appStoreLogo,
                        isAntiAlias: true,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(AppDecoration.spaceBig),
              Text(
                "1006@authSetup".tr,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(),
              Wrap(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => launchURL(AppInfo.authAuthy),
                      child: Image.asset(
                        AppImages.authyLogo,
                        isAntiAlias: true,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        verticalSpace(AppDecoration.spaceBig),
        Center(
          child: SizedBox(
            width: AppDecoration.widgetWidth,
            height: AppDecoration.buttonHeightLarge,
            child: ElevatedButton(
              onPressed: () {
                tabController.animateTo(_authSetupController.toNextTab());
              },
              child: Text("1027@global".tr),
            ),
          ),
        ),
      ],
    );
  }
}
