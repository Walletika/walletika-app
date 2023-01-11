import 'package:flutter/material.dart';

import '../widgets/header.dart';
import 'body.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MainHeader.height),
        child: MainHeader(actionsVisible: false),
      ),
      body: TransactionBody(),
    );
  }
}
