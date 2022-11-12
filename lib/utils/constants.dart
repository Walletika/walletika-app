import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'swatching.dart';

class AppInfo {
  static const String name = 'Walletika';
  static const String version = '1.0';
  static const String website = 'https://www.walletika.com';
  static const String network = 'Ethereum';
  static const String donateAddress =
      '0x9BfDe70BF991697bCD8bAD287D2C46AaD662544d';
}

class AppDecoration {
  static const double radius = 10.0;
  static const double margin = 10.0;
  static const double padding = 10.0;
  static const double paddingMedium = 30.0;
  static const double paddingLarge = 50.0;
  static const double elevation = 20.0;
  static const double iconSize = 24.0;
  static const double iconSmallSize = 20.0;
  static const double dividerPadding = 20.0;
  static const double widgetWidth = 350.0;
  static const double buttonHeight = 35.0;
  static const double buttonHeightLarge = 50.0;
}

class AppColors {
  static const Color font = Color(0xff141416);
  static const Color font2 = Color(0xff747f8c);
  static const Color fontDark = Color(0xffffffff);
  static const Color background = Color(0xfffcfcfd);
  static const Color background2 = Color(0xfff0f2f5);
  static const Color background2Dark = Color(0xff23262f);
  static const Color background3 = Color(0xffe4e6eb);
  static const Color background3Dark = Color(0xff23262f);
  static const Color backgroundDark = Color(0xff141416);
  static const Color line = Color(0xfff0f2f5);
  static const Color lineDark = Color(0xff23262f);
  static const Color icon = Color(0xff606770);
  static const Color highlight = Color(0xff1652f0);
  static const Color highlightHover = Color(0xff0a46e4);
  static const Color green = Color(0xff05b169);
  static const Color red = Color(0xffff0000);

  static final MaterialColor highlightMaterial = MaterialColor(
    highlight.value,
    getSwatch(highlight),
  );
}

class AppFonts {
  static const String normal = 'Segoe UI';
}

class AppImages {
  static const String logo = 'assets/logos/walletika.png';
  static const String coinIllustrations = 'assets/illustrations/coin.png';
  static const String dayIllustrations = 'assets/illustrations/day.jpg';
  static const String nightIllustrations = 'assets/illustrations/night.jpg';
}

class AppPages {
  static const String home = '/';
  static const String settings = '/settings';
  static const String network = '/settings/network';
  static const String addWallet = '/addWallet';

  static bool get isHome => Get.currentRoute == AppPages.home;
}

class AppLanguages {
  static const String en = 'en';
  static const String ar = 'ar';
}
