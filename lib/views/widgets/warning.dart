import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class WarningText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const WarningText({
    required this.text,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          LineIcons.exclamationTriangle,
          color: Colors.orange,
          size: 40.0,
        ),
        horizontalSpace(),
        Flexible(
          child: SizedBox(
            width: AppDecoration.widgetWidth,
            child: Text(
              text,
              style: style ?? Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ),
      ],
    );
  }
}
