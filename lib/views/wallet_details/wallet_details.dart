import 'package:flutter/material.dart';

import '../widgets/header.dart';
import 'body.dart';

class WalletDetailsView extends StatelessWidget {
  const WalletDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(),
      ),
      body: WalletDetailsBody(),
    );
  }
}
