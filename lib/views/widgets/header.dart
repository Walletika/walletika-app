import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    this.backgroundTransparent = false,
    this.backButtonVisible = true,
    this.brandVisible = true,
    this.actionsVisible = true,
    super.key,
  });

  static const double height = 80.0;
  final bool backgroundTransparent;
  final bool backButtonVisible;
  final bool brandVisible;
  final bool actionsVisible;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      toolbarHeight: height,
      backgroundColor: backgroundTransparent ? Colors.transparent : null,
      leadingWidth: 15.0,
      leading: zeroSpace(),
      title: Row(
        children: [
          ...backButtonVisible
              ? [
                  IconButton(
                    onPressed: Get.back,
                    tooltip: "1003@global".tr,
                    icon: const Icon(LineIcons.angleLeft),
                  )
                ]
              : [],
          ...brandVisible
              ? [
                  GestureDetector(
                    onTap: () => Get.until((route) => AppPages.isHome),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        message: "1000@home".tr,
                        child: Image.asset(
                          AppImages.logo,
                          width: 40.0,
                          filterQuality: FilterQuality.medium,
                          isAntiAlias: true,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(),
                  Flexible(
                    child: Text(
                      AppInfo.name,
                      softWrap: false,
                      style: textTheme.titleMedium,
                    ),
                  ),
                ]
              : [],
        ],
      ),
      actions: actionsVisible
          ? [
              IconButton(
                padding: EdgeInsets.zero,
                tooltip: "1000@settings".tr,
                onPressed: () => Get.toNamed(AppPages.settings),
                icon: const Icon(LineIcons.cog),
              ),
              horizontalSpace(),
            ]
          : null,
    );
  }
}
