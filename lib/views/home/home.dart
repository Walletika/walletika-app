import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import '../widgets/header.dart';
import 'body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(backButtonVisible: false),
      ),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddWalletClicked,
        tooltip: "1003@home".tr,
        elevation: AppDecoration.elevation,
        child: const Icon(LineIcons.plus),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _onAddWalletClicked() {
    Get.toNamed(AppPages.addWallet);
  }
}
