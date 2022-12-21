import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/settings/settings.dart';
import '../../utils/constants.dart';
import 'spacer.dart';

class NetworkWarning extends StatelessWidget {
  NetworkWarning({
    required this.text,
    required this.onTap,
    super.key,
  });

  final String text;
  final void Function() onTap;

  final SettingsController _settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          LineIcons.exclamationTriangle,
          color: Colors.orange,
          size: 40.0,
        ),
        horizontalSpace(),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontFamily: AppFonts.medium,
                    ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onTap,
                  child: Obx(() {
                    return Text(
                      _settingsController.currentNetwork,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
