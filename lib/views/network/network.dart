import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../widgets/header.dart';
import 'body.dart';

class NetworkView extends StatelessWidget {
  const NetworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(actionsVisible: false),
      ),
      body: NetworkBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "1001@network".tr,
        elevation: AppDecoration.elevation,
        child: const Icon(Icons.add_rounded),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
