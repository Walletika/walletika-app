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
        Obx(() {
          return Image.asset(
            _settingsController.isDarkMode
                ? AppImages.nightIllustrations
                : AppImages.dayIllustrations,
            filterQuality: FilterQuality.medium,
            isAntiAlias: true,
            fit: BoxFit.cover,
          );
        }),
        // Content
        Container(
          padding: const EdgeInsets.all(AppDecoration.padding),
          color: Theme.of(context).backgroundColor.withOpacity(0.7),
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
                    icon: const Icon(LineIcons.angleRight),
                    borderRadius: BorderRadius.circular(AppDecoration.radius),
                    dropdownColor: Theme.of(context).backgroundColor,
                    underline: zeroSpace(),
                    value: _settingsController.currentLanguage,
                    onChanged: _settingsController.languageUpdate,
                    items: _settingsController.languages
                        .map((key, value) {
                          return MapEntry(
                            key,
                            DropdownMenuItem(value: key, child: Text(value)),
                          );
                        })
                        .values
                        .toList(),
                  );
                }),
              ),
              ListTile(
                onTap: () => Get.toNamed(AppPages.network),
                title: Text("1003@settings".tr),
                subtitle: Obx(() => Text(_settingsController.currentNetwork)),
                trailing: const Icon(LineIcons.angleRight),
              ),
              const Divider(
                indent: AppDecoration.dividerPadding,
                endIndent: AppDecoration.dividerPadding,
              ),
              ListTile(
                title: Text("1004@settings".tr),
                subtitle: ButtonBar(
                  children: [
                    SizedBox(
                      height: AppDecoration.buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("1005@settings".tr),
                      ),
                    ),
                    SizedBox(
                      height: AppDecoration.buttonHeight,
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
      ],
    );
  }
}
