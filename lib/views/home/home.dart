import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletika/utils/constants.dart';

import 'footer.dart';
import 'header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(headerHeight),
        child: HeaderWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Create New Wallet".tr,
        elevation: AppDecoration.elevation,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
