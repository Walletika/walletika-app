import 'package:flutter/material.dart';

import 'header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(headerHeight),
        child: HeaderWidget(),
      ),
    );
  }
}
