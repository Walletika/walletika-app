import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/tabs/tabs.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/spacer.dart';
import 'download_tab.dart';
import 'verification_tab.dart';
import 'scan_tab.dart';
import 'finish_tab.dart';

class AuthSetupBody extends StatefulWidget {
  const AuthSetupBody({super.key});

  @override
  State<AuthSetupBody> createState() => _AuthSetupBodyState();
}

class _AuthSetupBodyState extends State<AuthSetupBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TabsController _tabsController = Get.find<TabsController>();

  @override
  void initState() {
    _tabController = TabController(
      length: _tabsController.totalTabs,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = [
      "1000@authSetup".tr,
      "1001@authSetup".tr,
      "1002@authSetup".tr,
    ];

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        ContainerWithShadow(
          padding: const EdgeInsets.only(
            top: AppDecoration.padding,
            left: AppDecoration.padding,
            right: AppDecoration.padding,
            bottom: AppDecoration.paddingMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < tabs.length; index++) ...[
                Flexible(
                  flex: 3,
                  child: Obx(() {
                    final bool isCompleted =
                        _tabsController.currentTabIndex > index;

                    return Column(
                      children: [
                        Text(
                          tabs[index],
                          textAlign: TextAlign.center,
                          style: _tabsController.currentTabIndex == index
                              ? textTheme.bodySmall!.copyWith(
                                  fontFamily: AppFonts.bold,
                                  fontSize: AppFonts.smallestSize,
                                )
                              : textTheme.labelSmall!.copyWith(
                                  fontSize: AppFonts.smallestSize,
                                ),
                        ),
                        verticalSpace(),
                        Icon(
                          isCompleted ? LineIcons.checkCircle : LineIcons.clock,
                          color: isCompleted ? AppColors.green : null,
                        ),
                      ],
                    );
                  }),
                ),
                if (index < tabs.length - 1) ...[
                  horizontalSpace(),
                  const Flexible(
                    child: SizedBox(width: 100.0, child: Divider()),
                  ),
                  horizontalSpace(),
                ]
              ]
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AuthDownloadTabView(tabController: _tabController),
              AuthVerificationTabView(tabController: _tabController),
              AuthScanTabView(tabController: _tabController),
              const AuthFinishTabView(),
            ],
          ),
        ),
      ],
    );
  }
}
