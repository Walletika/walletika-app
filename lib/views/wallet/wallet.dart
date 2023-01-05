import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/tabs/tabs.dart';
import '../../utils/constants.dart';
import '../widgets/header.dart';
import 'body.dart';

class WalletView extends StatelessWidget {
  WalletView({super.key});

  final TabsController tabsController = Get.put(
    TabsController(2),
    tag: AppPages.wallet,
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(backgroundTransparent: true),
      ),
      body: WalletBody(),
    );
  }
}
