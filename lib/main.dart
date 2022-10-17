import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/constants.dart';
import 'views/home/home.dart';

void main() {
  runApp(const WalletikaApp());
}

class WalletikaApp extends StatelessWidget {
  const WalletikaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: AppInfo.name,
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
