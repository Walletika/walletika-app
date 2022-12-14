import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import 'active_status.dart';
import 'address.dart';
import 'spacer.dart';

class WalletItem extends StatelessWidget {
  const WalletItem({
    required this.username,
    required this.address,
    this.isActive = false,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String username;
  final String address;
  final bool isActive;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      minVerticalPadding: 20.0,
      onTap: onTap,
      leading: Image.asset(
        AppImages.walletIllustrations,
        width: 50.0,
        height: 50.0,
        isAntiAlias: true,
        filterQuality: FilterQuality.medium,
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              username,
              softWrap: false,
              style: textTheme.bodyLarge!.copyWith(fontFamily: AppFonts.bold),
            ),
          ),
          ...isActive
              ? [
                  horizontalSpace(),
                  ActiveStatus(isActive: isActive, tooltip: "1035@global".tr),
                ]
              : []
        ],
      ),
      subtitle: TextAddress(
        address,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      trailing: trailing,
    );
  }
}
