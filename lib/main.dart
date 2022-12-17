import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:walletika_api/walletika_api.dart';

import 'controllers/dependencies.dart';
import 'locales/locales.dart';
import 'services/settings.dart';
import 'utils/constants.dart';
import 'views/account_details/account_details.dart';
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

void main() async {
  // WidgetsFlutterBinding.ensureInitialized() is implemented by GetStorage
  await initServices();
  runApp(WalletikaApp());
}

Future<void> initServices() async {
  await WalletikaAPI.init(
    'key',
    directory: await getApplicationSupportDirectory().then((dir) => dir.path),
  );
  await Get.putAsync(() => SettingsService().init(), permanent: true);
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
        GetPage(
          name: AppPages.accountDetails,
          page: () => const AccountDetailsView(),
        ),
      ],
    );
  }
}
