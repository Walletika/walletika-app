import 'package:flutter/material.dart';

import 'text_copyable.dart';

class TextAddress extends StatelessWidget {
  final String data;
  final double? width;
  final double height;
  final MainAxisAlignment mainAxisAlignment;

  const TextAddress(
    this.data, {
    this.width,
    this.height = 22.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextCopyable(
      data,
      width: width,
      height: height,
      softWrap: false,
      style: Theme.of(context).textTheme.labelSmall,
      mainAxisAlignment: mainAxisAlignment,
    );
  }
}
