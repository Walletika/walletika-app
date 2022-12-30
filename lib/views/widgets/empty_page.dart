import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    this.illustrationPath,
    this.title,
    this.desc,
    this.actions,
    super.key,
  });

  final String? illustrationPath;
  final String? title;
  final String? desc;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppDecoration.paddingMedium),
      child: Column(
        children: [
          ...illustrationPath != null
              ? [
                  Flexible(
                    child: Image.asset(
                      illustrationPath!,
                      filterQuality: FilterQuality.medium,
                      isAntiAlias: true,
                    ),
                  )
                ]
              : [],
          ...title != null
              ? [
                  Text(
                    title!,
                    style: textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  )
                ]
              : [],
          verticalSpace(AppDecoration.spaceSmall),
          ...desc != null
              ? [
                  Text(
                    desc!,
                    style: textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  )
                ]
              : [],
          ...actions ?? [],
        ],
      ),
    );
  }
}
