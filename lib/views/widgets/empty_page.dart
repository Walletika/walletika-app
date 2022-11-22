import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'spacer.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    required this.illustrationPath,
    required this.title,
    required this.desc,
    super.key,
  });

  final String illustrationPath;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDecoration.paddingMedium),
      child: Column(
        children: [
          Flexible(
            child: Image.asset(
              illustrationPath,
              filterQuality: FilterQuality.medium,
              isAntiAlias: true,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          verticalSpace(AppDecoration.spaceSmall),
          Text(
            desc,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
