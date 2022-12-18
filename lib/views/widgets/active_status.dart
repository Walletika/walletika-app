import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ActiveStatus extends StatelessWidget {
  const ActiveStatus({
    required this.isActive,
    required this.tooltip,
    super.key,
  });

  final bool isActive;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? AppColors.green : Colors.grey;
    final RoundedRectangleBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDecoration.radius),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 7.0,
          height: 7.0,
          child: Material(color: color, shape: shape),
        ),
        Tooltip(
          message: tooltip,
          child: SizedBox(
            width: 15.0,
            height: 15.0,
            child: Material(color: color.withOpacity(0.2), shape: shape),
          ),
        ),
      ],
    );
  }
}
