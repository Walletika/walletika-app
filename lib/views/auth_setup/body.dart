import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/auth_setup/auth_setup.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/spacer.dart';
import 'first_tab.dart';
import 'second_tab.dart';
import 'third_tab.dart';

class AuthSetupBody extends StatefulWidget {
  const AuthSetupBody({super.key});

  @override
  State<AuthSetupBody> createState() => _AuthSetupBodyState();
}

class _AuthSetupBodyState extends State<AuthSetupBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AuthSetupController _authSetupController =
      Get.find<AuthSetupController>();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = [
      "1000@authSetup".tr,
      "1001@authSetup".tr,
      "1002@authSetup".tr,
    ];

    return Column(
      children: [
        ContainerWithShadow(
          padding: const EdgeInsets.all(AppDecoration.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < tabs.length; index++) ...[
                Flexible(
                  flex: 3,
                  child: Obx(() {
                    final bool isCompleted =
                        _authSetupController.currentTabIndex > index;

                    return Column(
                      children: [
                        Text(
                          tabs[index],
                          textAlign: TextAlign.center,
                          style: _authSetupController.currentTabIndex == index
                              ? Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontFamily: AppFonts.bold,
                                  )
                              : Theme.of(context).textTheme.labelSmall,
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
            children: [
              AuthFirstTabView(tabController: _tabController),
              AuthSecondTabView(tabController: _tabController),
              AuthThirdTabView(tabController: _tabController),
            ],
          ),
        ),
      ],
    );
  }
}
