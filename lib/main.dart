import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/dependencies.dart';
import 'utils/constants.dart';
import 'views/home/home.dart';
import 'views/settings/settings.dart';
import 'views/widgets/themes.dart';

void main() {
  runApp(const WalletikaApp());
}

class WalletikaApp extends StatelessWidget {
  const WalletikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppInfo.name,
      debugShowCheckedModeBanner: false,
      theme: walletikaDefaultTheme,
      darkTheme: walletikaDarkTheme,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.cupertino,
      initialBinding: AppBinding(),
      initialRoute: AppPages.home,
      getPages: [
        GetPage(name: AppPages.home, page: () => const HomeView()),
        GetPage(name: AppPages.settings, page: () => const SettingsView()),
      ],
    );
  }
}
