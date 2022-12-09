import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ItemLogo extends StatelessWidget {
  const ItemLogo({
    required this.path,
    this.size = 40.0,
    this.errorPath = '${AppImages.coins}/unknown.png',
    super.key,
  });

  final String path;
  final double? size;
  final String? errorPath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
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
    );
  }
}
