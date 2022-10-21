import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

const double headerHeight = 80.0;

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: headerHeight,
      leadingWidth: 60.0,
      leading: Row(
        children: [
          horizontalSpace(),
          Image.asset(
            AppImages.logo,
            width: 45.0,
            filterQuality: FilterQuality.medium,
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
