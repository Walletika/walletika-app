import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/constants.dart';
import 'views/home/home.dart';
import 'views/widgets/themes.dart';

void main() {
  runApp(const WalletikaApp());
}

class WalletikaApp extends StatelessWidget {
  const WalletikaApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppInfo.name,
      debugShowCheckedModeBanner: false,
      theme: walletikaDefaultTheme,
      darkTheme: walletikaDarkTheme,
      themeMode: ThemeMode.light,
      home: const HomeView(),
    );
  }
}
