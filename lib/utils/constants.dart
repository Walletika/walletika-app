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
  static const String authGooglePlay =
      'https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en&gl=US';
  static const String authAppStore =
      'https://apps.apple.com/us/app/google-authenticator/id388497605';
  static const String authAuthy = 'https://authy.com/download';
  static final bool isDesktop = GetPlatform.isDesktop;
  static final bool isAndroid = GetPlatform.isAndroid;
}

class AppDecoration {
  static const double radiusSmall = 5.0;
  static const double radius = 10.0;
  static const double radiusMedium = 20.0;
  static const double radiusBig = 30.0;
  static const double radiusLarge = 50.0;
  static const double margin = 10.0;
  static const double padding = 10.0;
  static const double paddingMedium = 20.0;
  static const double paddingBig = 30.0;
  static const double paddingLarge = 50.0;
  static const double spaceSmall = 5.0;
  static const double space = 10.0;
  static const double spaceMedium = 20.0;
  static const double spaceBig = 30.0;
  static const double spaceLarge = 50.0;
  static const double elevation = 20.0;
  static const double iconSize = 24.0;
  static const double iconSmallSize = 20.0;
  static const double dividerPadding = 20.0;
  static const double widgetWidth = 300.0;
  static const double buttonHeight = 35.0;
  static const double buttonHeightLarge = 50.0;
  static const String invisibleText = '******';
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

  static final MaterialColor highlightMaterial = MaterialColor(
    highlight.value,
    getSwatch(highlight),
  );
}

class AppFonts {
  static const String normal = 'Roboto';
  static const String light = 'Roboto Light';
  static const String medium = 'Roboto Medium';
  static const String bold = 'Roboto Bold';
  static const String black = 'Roboto Black';
  static const double displayLargeSize = 30.0;
  static const double displayMediumSize = 28.0;
  static const double displaySmallSize = 26.0;
  static const double headlineLargeSize = 24.0;
  static const double headlineMediumSize = 22.0;
  static const double headlineSmallSize = 20.0;
  static const double largeSize = 18.0;
  static const double mediumSize = 16.0;
  static const double smallSize = 14.0;
  static const double smallestSize = 12.0;
}

class AppImages {
  static const String logo = 'assets/logos/walletika.png';
  static const String appStoreLogo = 'assets/logos/app_store.png';
  static const String googlePlayLogo = 'assets/logos/google_play.png';
  static const String authyLogo = 'assets/logos/authy.png';
  static const String coinIllustrations = 'assets/illustrations/coin.png';
  static const String emptyIllustrations = 'assets/illustrations/empty.png';
  static const String doneIllustrations = 'assets/illustrations/done.png';
  static const String confirmIllustrations = 'assets/illustrations/confirm.png';
  static const String dayIllustrations = 'assets/illustrations/day.jpg';
  static const String nightIllustrations = 'assets/illustrations/night.jpg';
  static const String walletIllustrations = 'assets/illustrations/wallet.png';
  static const String authIllustrations = 'assets/illustrations/auth.png';
  static const String unknownCoinIllustrations =
      'assets/illustrations/unknown.png';
}

class AppPages {
  static const String home = '/';
  static const String settings = '/settings';
  static const String network = '/settings/network';
  static const String addNetwork = '/settings/network/addNetwork';
  static const String addWallet = '/addWallet';
  static const String login = '/login';
  static const String auth = '/login/auth';
  static const String authSetup = '/login/auth/authSetup';
  static const String wallet = '/login/auth/wallet';
  static const String walletDetails = '/login/auth/wallet/walletDetails';
  static const String depsoit = '/login/auth/wallet/depsoit';

  static bool get isHome => Get.currentRoute == AppPages.home;
}

class AppLanguages {
  static const String en = 'en';
  static const String ar = 'ar';
}

class AppRegExp {
  static final RegExp letters = RegExp(r'[0-z-!-~ ]');
  static final RegExp lettersWithoutSpace = RegExp(r'[0-z-!-~]');
  static final RegExp alphabet = RegExp(r'^[a-zA-Z]+$');
  static final RegExp number = RegExp(r'[0-9]');
  static final RegExp lowercase = RegExp(r'[a-z]');
  static final RegExp uppercase = RegExp(r'[A-Z]');
  static final RegExp address = RegExp(r'0x?[0-9-a-f-A-F]{40}');
  static final RegExp balance = RegExp(r'[-+]?[0-9]*\.?[0-9]+');
  static final RegExp url = RegExp(
    r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?',
  );
}
