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
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppDecoration.paddingBig),
              children: [
                Row(
                  children: [
                    const Icon(LineIcons.cog),
                    horizontalSpace(),
                    Text(
                      "1000@settings".tr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                verticalSpace(AppDecoration.spaceMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1001@settings".tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Obx(() {
                      return Switch.adaptive(
                        value: _settingsController.isDarkMode,
                        onChanged: _onDarkModeChanged,
                      );
                    }),
                  ],
                ),
                verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1002@settings".tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Obx(() {
                      return DropdownButton(
                        style: Theme.of(context).popupMenuTheme.textStyle,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        borderRadius:
                            BorderRadius.circular(AppDecoration.radius),
                        dropdownColor: Theme.of(context).popupMenuTheme.color,
                        underline: zeroSpace(),
                        value: _settingsController.currentLanguage,
                        onChanged: _onLanguageChanged,
                        items: _settingsController.languages
                            .map((key, value) {
                              return MapEntry(
                                key,
                                DropdownMenuItem(
                                    value: key, child: Text(value)),
                              );
                            })
                            .values
                            .toList(),
                      );
                    }),
                  ],
                ),
                verticalSpace(),
                InkWell(
                  onTap: () => Get.toNamed(AppPages.network),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1003@settings".tr,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            verticalSpace(AppDecoration.spaceSmall),
                            Obx(() {
                              return Text(
                                _settingsController.currentNetwork,
                                style: Theme.of(context).textTheme.labelMedium,
                              );
                            }),
                          ],
                        ),
                      ),
                      const Icon(LineIcons.angleRight),
                    ],
                  ),
                ),
                verticalSpace(AppDecoration.spaceMedium),
                const Divider(
                  indent: AppDecoration.dividerPadding,
                  endIndent: AppDecoration.dividerPadding,
                ),
                verticalSpace(AppDecoration.spaceMedium),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1004@settings".tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    verticalSpace(AppDecoration.spaceBig),
                    Center(
                      child: SizedBox(
                        width: AppDecoration.widgetWidth,
                        height: AppDecoration.buttonHeightLarge,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("1005@settings".tr),
                        ),
                      ),
                    ),
                    verticalSpace(),
                    Center(
                      child: SizedBox(
                        width: AppDecoration.widgetWidth,
                        height: AppDecoration.buttonHeightLarge,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("1006@settings".tr),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onDarkModeChanged(bool enabled) {
    final OperationNotifier operation = OperationNotifier(
      title: "0xC495fdf7",
    );

    _settingsController.darkModeUpdate(enabled).catchError((error) {
      operation.error(error.toString());
      operation.notify();
    });
  }

  void _onLanguageChanged(String? language) {
    final OperationNotifier operation = OperationNotifier(
      title: "0x7648bddc",
    );

    _settingsController.languageUpdate(language).catchError((error) {
      operation.error(error.toString());
      operation.notify();
    });
  }
}
