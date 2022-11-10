import 'package:flutter/material.dart';

import 'address.dart';
import 'itemlogo.dart';

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
    return ListTile(
      minVerticalPadding: 15.0,
      onTap: onTap,
      leading: ItemLogo(
        path: 'assets/illustrations/wallet.png',
        isActive: isActive,
      ),
      title: Text(
        username,
        softWrap: false,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: TextAddress(address, height: 30.0),
      trailing: trailing,
    );
  }
}