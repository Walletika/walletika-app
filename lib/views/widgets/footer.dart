import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import 'address.dart';
import 'spacer.dart';

class MainFooter extends StatelessWidget {
  const MainFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41.0,
      child: Column(
        children: [
          const Divider(),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text("1004@global".tr)),
                horizontalSpace(),
                const Flexible(
                  child: TextAddress(AppInfo.donateAddress),
                ),
                VerticalDivider(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  width: 5.0,
                  indent: 12.0,
                  endIndent: 12.0,
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: () => launchURL(AppInfo.website),
                    child: const Text("Walletika.com"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
