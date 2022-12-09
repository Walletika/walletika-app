import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ActiveStatus extends StatelessWidget {
  const ActiveStatus({
    required this.isActive,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 7.0,
          height: 7.0,
          child: Material(
            color: isActive ? AppColors.green : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDecoration.radius),
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
          height: 15.0,
          child: Material(
            color: isActive
                ? AppColors.green.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDecoration.radius),
            ),
          ),
        ),
      ],
    );
  }
}
