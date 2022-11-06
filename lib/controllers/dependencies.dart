import 'package:get/get.dart';

import 'network/network_manager.dart';
import 'settings/settings.dart';
import 'wallet/wallet_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController(), permanent: true);
    Get.put(NetworkManagerController(), permanent: true);
    Get.put(WalletManagerController(), permanent: true);
  }
}
