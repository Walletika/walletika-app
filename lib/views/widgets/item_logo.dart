import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ItemLogo extends StatelessWidget {
  const ItemLogo({
    required this.imageURL,
    this.size = 40.0,
    super.key,
  });

  final String imageURL;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      placeholder: (c, u) => const CircularProgressIndicator.adaptive(),
      errorWidget: (c, u, e) => Image.asset(
        AppImages.unknownCoinIllustrations,
        width: size,
        height: size,
        isAntiAlias: true,
        filterQuality: FilterQuality.medium,
      ),
      width: size,
      height: size,
      filterQuality: FilterQuality.medium,
    );
  }
}
