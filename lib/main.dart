import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:walletika_api/walletika_api.dart';

import 'controllers/dependencies.dart';
import 'locales/locales.dart';
import 'services/settings.dart';
import 'utils/constants.dart';
import 'utils/desktop_window.dart';
import 'views/deposit/deposit.dart';
import 'views/wallet_details/wallet_details.dart';
import 'views/add_network/add_network.dart';
import 'views/auth_setup/auth_setup.dart';
import 'views/home/home.dart';
import 'views/login/login.dart';
import 'views/auth/auth.dart';
import 'views/network/network.dart';
import 'views/settings/settings.dart';
import 'views/add_wallet/add_wallet.dart';
import 'views/wallet/wallet.dart';
import 'views/widgets/themes.dart';
import 'views/withdraw/withdraw.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();
  await initDesktopWindow();

  runApp(WalletikaApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => SettingsService().init(), permanent: true);
  await WalletikaAPI.init(
    'key',
    directory: await getApplicationSupportDirectory().then((dir) => dir.path),
  );
}

class WalletikaApp extends StatelessWidget {
  WalletikaApp({super.key});

  final SettingsService settingsService = Get.find<SettingsService>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppInfo.name,
      debugShowCheckedModeBanner: false,
      theme: walletikaDefaultTheme,
      darkTheme: walletikaDarkTheme,
      themeMode: settingsService.theme,
      locale: settingsService.locale,
      translations: AppTranslator(),
      textDirection: TextDirection.ltr,
      defaultTransition: Transition.cupertino,
      initialBinding: AppBinding(),
      initialRoute: AppPages.home,
      getPages: [
        GetPage(name: AppPages.home, page: () => const HomeView()),
        GetPage(name: AppPages.settings, page: () => const SettingsView()),
        GetPage(name: AppPages.network, page: () => const NetworkView()),
        GetPage(name: AppPages.addNetwork, page: () => const AddNetworkView()),
        GetPage(name: AppPages.addWallet, page: () => const AddWalletView()),
        GetPage(name: AppPages.login, page: () => const LoginView()),
        GetPage(name: AppPages.auth, page: () => const AuthView()),
        GetPage(name: AppPages.authSetup, page: () => AuthSetupView()),
        GetPage(name: AppPages.wallet, page: () => WalletView()),
        GetPage(name: AppPages.withdraw, page: () => WithdrawView()),
        GetPage(
          name: AppPages.walletDetails,
          page: () => const WalletDetailsView(),
        ),
        GetPage(name: AppPages.depsoit, page: () => const DepositView()),
      ],
    );
  }
}
