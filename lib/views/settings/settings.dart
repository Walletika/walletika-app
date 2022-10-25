import 'package:flutter/material.dart';

import '../widgets/header.dart';
import 'body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(actionsVisible: false),
      ),
      body: SettingsBody(),
      resizeToAvoidBottomInset: false,
    );
  }
}
