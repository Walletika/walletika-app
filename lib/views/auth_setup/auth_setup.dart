import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_setup/auth_setup.dart';
import '../widgets/header.dart';
import 'body.dart';

class AuthSetupView extends StatelessWidget {
  AuthSetupView({super.key});

  final controller = Get.put(AuthSetupController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(),
      ),
      body: AuthSetupBody(),
    );
  }
}
