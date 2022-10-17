import 'package:flutter/material.dart';

import 'swatching.dart';

class AppInfo {
  static const String name = 'Walletika';
  static const String version = '1.0';
  static const String website = 'https://www.walletika.com';
  static const String donateAddress =
      '0x9BfDe70BF991697bCD8bAD287D2C46AaD662544d';
}

class AppColors {
  static const Color font = Color(0xff141416);
  static const Color font2 = Color(0xff747f8c);
  static const Color fontDark = Color(0xffffffff);
  static const Color background = Color(0xfffcfcfd);
  static const Color background2 = Color(0xfff0f2f5);
  static const Color background3 = Color(0xffe4e6eb);
  static const Color backgroundDark = Color(0xff141416);
  static const Color line = Color(0xfff0f2f5);
  static const Color lineDark = Color(0xff252525);
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
}
