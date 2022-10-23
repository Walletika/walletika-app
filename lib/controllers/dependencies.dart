import 'package:get/get.dart';

import 'wallet/wallet_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WalletManagerController(), permanent: true);
  }
}
