import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/tabs/tabs.dart';
import '../widgets/header.dart';
import 'body.dart';

class WalletView extends StatelessWidget {
  WalletView({super.key});

  final TabsController tabsController = Get.put(TabsController(2));

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(),
      ),
      body: WalletBody(),
    );
  }
}
