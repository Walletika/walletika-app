import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CircularProgressValueIndicator extends StatelessWidget {
  const CircularProgressValueIndicator(this.value, {super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Text(
          '$value%',
          style: textTheme.bodyLarge!.copyWith(
            color: AppColors.highlight,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator.adaptive(value: value / 100),
        ),
      ],
    );
  }
}
