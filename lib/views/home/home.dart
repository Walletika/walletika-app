import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        onPressed: () {},
        tooltip: "Create New Wallet".tr,
        elevation: AppDecoration.elevation,
        child: const Icon(Icons.add_rounded),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
