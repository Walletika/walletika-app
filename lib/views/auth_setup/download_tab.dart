import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/tabs/tabs.dart';
import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import '../widgets/spacer.dart';

class AuthDownloadTabView extends StatelessWidget {
  AuthDownloadTabView({required this.tabController, super.key});

  final TabController tabController;
  final TabsController _tabsController = Get.find<TabsController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDecoration.paddingMedium,
        vertical: AppDecoration.paddingBig,
      ),
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
                  _applicationButton(
                    logo: AppImages.googlePlayLogo,
                    url: AppInfo.authGooglePlay,
                  ),
                  _applicationButton(
                    logo: AppImages.appStoreLogo,
                    url: AppInfo.authAppStore,
                  ),
                ],
              ),
              verticalSpace(AppDecoration.spaceBig),
              Text(
                "1006@authSetup".tr,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              verticalSpace(),
              _applicationButton(
                logo: AppImages.authyLogo,
                url: AppInfo.authAuthy,
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
              onPressed: _nextOnPressed,
              child: Text("1027@global".tr),
            ),
          ),
        ),
      ],
    );
  }

  void _nextOnPressed() {
    tabController.animateTo(_tabsController.toNextTab());
  }

  Widget _applicationButton({required String logo, required String url}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchURL(url),
        child: Image.asset(
          logo,
          isAntiAlias: true,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}
