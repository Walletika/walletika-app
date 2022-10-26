import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/settings/settings.dart';
import '../../utils/constants.dart';
import '../widgets/spacer.dart';

class SettingsBody extends StatelessWidget {
  SettingsBody({super.key});

  final SettingsController _settingsController = Get.find<SettingsController>();

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
          child: Obx(() {
            return Image.asset(
              _settingsController.isDarkMode
                  ? AppImages.nightIllustrations
                  : AppImages.dayIllustrations,
              filterQuality: FilterQuality.medium,
              isAntiAlias: true,
              fit: BoxFit.cover,
            );
          }),
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
                        "1000@settings".tr,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    ListTile(
                      title: Text("1001@settings".tr),
                      trailing: Obx(() {
                        return Switch.adaptive(
                          value: _settingsController.isDarkMode,
                          onChanged: _settingsController.darkModeUpdate,
                        );
                      }),
                    ),
                    ListTile(
                      title: Text("1002@settings".tr),
                      trailing: Obx(() {
                        return DropdownButton(
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          borderRadius: BorderRadius.circular(
                            AppDecoration.radius,
                          ),
                          dropdownColor: Theme.of(context).backgroundColor,
                          underline: zeroSpace(),
                          value: _settingsController.currentLanguage,
                          onChanged: _settingsController.languageUpdate,
                          items: _settingsController.languages
                              .map((key, value) {
                                return MapEntry(
                                    key,
                                    DropdownMenuItem(
                                      value: key,
                                      child: Text(value),
                                    ));
                              })
                              .values
                              .toList(),
                        );
                      }),
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text("1003@settings".tr),
                      subtitle: const Text("Ethereum"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: AppDecoration.iconSmallSize,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text("1004@settings".tr),
                      subtitle: ButtonBar(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 35.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("1005@settings".tr),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 35.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("1006@settings".tr),
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
