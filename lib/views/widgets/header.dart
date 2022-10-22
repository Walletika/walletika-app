import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  static const double height = 80.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      leadingWidth: AppPages.isHome ? 60.0 : 100.0,
      leading: Row(
        children: [
          horizontalSpace(),
          AppPages.isHome
              ? zeroSpace()
              : IconButton(
                  onPressed: Get.back,
                  tooltip: "Back".tr,
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: AppDecoration.iconSmallSize,
                  ),
                ),
          GestureDetector(
            onTap: () => Get.until((route) => AppPages.isHome),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Tooltip(
                message: "Home".tr,
                child: Image.asset(
                  AppImages.logo,
                  width: 45.0,
                  filterQuality: FilterQuality.medium,
                  isAntiAlias: true,
                ),
              ),
            ),
          ),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppInfo.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            "Decentralized Wallet v${AppInfo.version} ( Beta )",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          tooltip: "Settings".tr,
          onPressed: () {},
          icon: const Icon(LineIcons.cog),
        ),
        horizontalSpace(),
      ],
    );
  }
}
