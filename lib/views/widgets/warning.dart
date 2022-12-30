import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class WarningText extends StatelessWidget {
  const WarningText({
    required this.text,
    this.style,
    super.key,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

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
          child: SizedBox(
            width: AppDecoration.widgetWidth,
            child: Text(
              text,
              style: style ??
                  textTheme.labelSmall!.copyWith(
                    fontSize: AppFonts.smallestSize,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
