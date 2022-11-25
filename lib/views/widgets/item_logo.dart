import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class ItemLogo extends StatelessWidget {
  const ItemLogo({
    required this.path,
    required this.isActive,
    this.size = 50.0,
    this.errorPath = '${AppImages.coins}/unknown.png',
    super.key,
  });

  final String path;
  final bool isActive;
  final double? size;
  final String? errorPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Image.asset(
          path,
          width: size,
          height: size,
          isAntiAlias: true,
          filterQuality: FilterQuality.medium,
          errorBuilder: errorPath != null
              ? (context, error, stackTrace) {
                  return Image.asset(
                    errorPath!,
                    width: size,
                    height: size,
                    isAntiAlias: true,
                    filterQuality: FilterQuality.medium,
                  );
                }
              : null,
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
