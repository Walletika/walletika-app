import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

class SettingsBody extends StatelessWidget {
  SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Wallpaper image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
          child: Image.asset(
            AppImages.dayIllustrations,
            filterQuality: FilterQuality.medium,
            isAntiAlias: true,
            fit: BoxFit.cover,
          ),
        ),
        // Content
        Column(
          children: [
            // Space to appear the wallpaper image
            const Expanded(child: SizedBox()),
            // Content body
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(
                  left: AppDecoration.padding,
                  top: AppDecoration.padding,
                  right: AppDecoration.padding,
                ),
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.9),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(LineIcons.cog),
                      horizontalTitleGap: 0,
                      title: Text(
                        "Settings".tr,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    ListTile(
                      title: Text("Primary language".tr),
                      trailing: DropdownButton(
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        borderRadius: BorderRadius.circular(
                          AppDecoration.radius,
                        ),
                        dropdownColor: Theme.of(context).backgroundColor,
                        value: 'engligh',
                        onChanged: (value) {},
                        items: [
                          DropdownMenuItem(
                            child: Text("English".tr),
                            value: 'engligh',
                          ),
                          DropdownMenuItem(
                            child: Text("Arabic".tr),
                            value: 'erabic',
                          ),
                        ],
                      ),
                    ),
                    SwitchListTile.adaptive(
                      title: Text("Dark mode theme".tr),
                      value: false,
                      onChanged: (value) {},
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text("Current blockchain network".tr),
                      subtitle: const Text("Ethereum"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: AppDecoration.iconSmallSize,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        "Backup all your wallets to specific location on your system."
                            .tr,
                      ),
                      subtitle: ButtonBar(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 35.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Backup My Wallets".tr),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 35.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Import".tr),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
