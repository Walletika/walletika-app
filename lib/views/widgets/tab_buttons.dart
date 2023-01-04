import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/tabs/tabs.dart';
import '../../utils/constants.dart';
import 'spacer.dart';

class TabButtons extends StatelessWidget {
  const TabButtons({
    required this.tabViewController,
    required this.tabsController,
    required this.tabs,
    this.maxCount = 50,
    super.key,
  });

  final TabController tabViewController;
  final TabsController tabsController;
  final Map<String, int?> tabs;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(Get.context!).textTheme;
    const Border border = Border(
      bottom: BorderSide(color: AppColors.highlight, width: 3.0),
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).popupMenuTheme.color,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDecoration.radiusBig),
        ),
      ),
      child: Obx(() {
        const int startTabIndex = 0;
        final int lastTabIndex = tabs.length - 1;
        final int currentIndex = tabsController.currentTabIndex;
        final List<Widget> widgets = [];
        int index = 0;

        for (MapEntry<String, int?> tab in tabs.entries) {
          final Text text = Text(
            tab.key,
            style: textTheme.labelSmall!.copyWith(
              fontFamily: AppFonts.medium,
              color: index == currentIndex ? border.bottom.color : null,
            ),
          );

          widgets.add(Expanded(
            child: SizedBox(
              height: AppDecoration.buttonHeightLarge,
              child: Material(
                color: Colors.transparent,
                shape: index == currentIndex ? border : null,
                child: TextButton(
                  onPressed: () => tabViewController.animateTo(
                    tabsController.setTabIndex(
                      tabs.keys.toList().indexOf(tab.key),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: _borderRadius(
                        left: index == startTabIndex,
                        right: index == lastTabIndex,
                      ),
                    ),
                  ),
                  child: tab.value == null
                      ? text
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: text),
                            horizontalSpace(),
                            Container(
                              width: 25.0,
                              height: 15.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: index == currentIndex
                                    ? border.bottom.color
                                    : textTheme.labelSmall!.color,
                                borderRadius: BorderRadius.circular(
                                  AppDecoration.radius,
                                ),
                              ),
                              child: Text(
                                tab.value! > maxCount
                                    ? '+$maxCount'
                                    : tab.value.toString(),
                                style: textTheme.bodySmall!.copyWith(
                                  fontFamily: AppFonts.light,
                                  fontSize: 10.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ));

          index++;
        }

        return Row(children: widgets);
      }),
    );
  }

  BorderRadius _borderRadius({bool left = false, bool right = false}) {
    if (left) {
      return const BorderRadius.only(
        topLeft: Radius.circular(AppDecoration.radiusBig),
      );
    } else if (right) {
      return const BorderRadius.only(
        topRight: Radius.circular(AppDecoration.radiusBig),
      );
    }

    return const BorderRadius.only();
  }
}
