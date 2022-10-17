import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/launch_url.dart';
import '../widgets/address.dart';
import '../widgets/spacer.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Text("Donate".tr)),
          horizontalSpace(),
          const Flexible(
            child: TextAddress(AppInfo.donateAddress),
          ),
          VerticalDivider(
            color: Theme.of(context).textTheme.titleSmall!.color,
            width: 15.0,
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
    );
  }
}
