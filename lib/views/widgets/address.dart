import 'package:flutter/material.dart';

import 'text_copyable.dart';

class TextAddress extends StatelessWidget {
  const TextAddress(
    this.data, {
    this.width,
    this.height = 22.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    super.key,
  });

  final String data;
  final double? width;
  final double height;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextCopyable(
      data,
      width: width,
      height: height,
      softWrap: false,
      style: textTheme.labelSmall,
      mainAxisAlignment: mainAxisAlignment,
    );
  }
}
