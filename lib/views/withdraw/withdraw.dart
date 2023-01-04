import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/tabs/tabs.dart';
import '../../controllers/withdraw/withdraw.dart';
import '../../utils/constants.dart';
import '../widgets/header.dart';
import 'body.dart';

class WithdrawView extends StatelessWidget {
  WithdrawView({super.key});

  final WithdrawController withdrawController = Get.put(WithdrawController());
  final TabsController tabsController = Get.put(
    TabsController(2),
    tag: AppPages.withdraw,
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(),
      ),
      body: WithdrawBody(),
    );
  }
}
