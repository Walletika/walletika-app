import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/settings/settings.dart';
import '../../utils/constants.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/spacer.dart';

class SettingsBody extends StatelessWidget {
  SettingsBody({super.key});

  final SettingsController _settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
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
        Container(
          color: Theme.of(context).backgroundColor.withOpacity(0.7),
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "1000@settings".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  "1001@settings".tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Obx(() {
                  return Switch.adaptive(
                    value: _settingsController.isDarkMode,
                    onChanged: _darkModeOnChanged,
                  );
                }),
              ),
              ListTile(
                title: Text(
                  "1002@settings".tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Obx(() {
                  return DropdownButton(
                    style: Theme.of(context).popupMenuTheme.textStyle,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    borderRadius: BorderRadius.circular(AppDecoration.radius),
                    dropdownColor: Theme.of(context).popupMenuTheme.color,
                    underline: zeroSpace(),
                    value: _settingsController.currentLanguage,
                    onChanged: _languageOnChanged,
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
                title: Text(
                  "1003@settings".tr,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Obx(() {
                  return Text(
                    _settingsController.currentNetwork,
                    style: Theme.of(context).textTheme.labelMedium,
                  );
                }),
                trailing: const Icon(LineIcons.angleRight),
              ),
              verticalSpace(),
              const Divider(
                indent: AppDecoration.dividerPadding,
                endIndent: AppDecoration.dividerPadding,
              ),
              verticalSpace(),
              ListTile(
                title: Text(
                  "1004@settings".tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDecoration.padding),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: AppDecoration.space,
                  runSpacing: AppDecoration.space,
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

  void _darkModeOnChanged(bool enabled) {
    final OperationNotifier operation = OperationNotifier(
      title: "0xC495fdf7",
    );

    _settingsController.darkModeUpdate(enabled).catchError((error) {
      operation.error(error.toString());
      operation.notify();
    });
  }

  void _languageOnChanged(String? language) {
    final OperationNotifier operation = OperationNotifier(
      title: "0x7648bddc",
    );

    _settingsController.languageUpdate(language).catchError((error) {
      operation.error(error.toString());
      operation.notify();
    });
  }
}
