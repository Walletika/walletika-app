import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'text_copyable.dart';

class TextAddress extends StatelessWidget {
  final String data;
  final double? width;
  final double? height;

  const TextAddress(this.data, {this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return TextCopyable(
      data,
      width: width,
      height: height,
      softWrap: false,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.font2,
          ),
    );
  }
}
