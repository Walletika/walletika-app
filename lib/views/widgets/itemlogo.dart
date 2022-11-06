import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class ItemLogo extends StatelessWidget {
  const ItemLogo({
    required this.path,
    required this.isActive,
    super.key,
  });

  final String path;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Image.asset(
          path,
          width: 50.0,
          height: 50.0,
          isAntiAlias: true,
          filterQuality: FilterQuality.medium,
        ),
        isActive
            ? SizedBox(
                width: 15.0,
                height: 15.0,
                child: Material(
                  color: AppColors.green,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).backgroundColor,
                      width: 2.0,
                      strokeAlign: StrokeAlign.outside,
                    ),
                    borderRadius: BorderRadius.circular(AppDecoration.radius),
                  ),
                ),
              )
            : zeroSpace(),
      ],
    );
  }
}
