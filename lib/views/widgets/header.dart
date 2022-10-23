import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    this.backgroundTransparent = false,
    this.brandVisible = true,
    super.key,
  });

  static const double height = 80.0;
  final bool backgroundTransparent;
  final bool brandVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      backgroundColor: backgroundTransparent ? Colors.transparent : null,
      leadingWidth: AppPages.isHome ? 60.0 : 105.0,
      leading: Row(
        children: [
          horizontalSpace(15.0),
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
          brandVisible
              ? GestureDetector(
                  onTap: () => Get.until((route) => AppPages.isHome),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Tooltip(
                      message: "Home".tr,
                      child: Image.asset(
                        AppImages.logo,
                        width: 40.0,
                        filterQuality: FilterQuality.medium,
                        isAntiAlias: true,
                      ),
                    ),
                  ),
                )
              : zeroSpace(),
        ],
      ),
      title: brandVisible
          ? Text(
              AppInfo.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
            )
          : zeroSpace(),
      actions: [
        AppPages.isSettings
            ? zeroSpace()
            : IconButton(
                padding: EdgeInsets.zero,
                tooltip: "Settings".tr,
                onPressed: () => Get.toNamed(AppPages.settings),
                icon: const Icon(LineIcons.cog),
              ),
        horizontalSpace(),
      ],
    );
  }
}
