import 'package:get/get.dart';

import 'addresses_book/addresses_book.dart';
import 'network/network.dart';
import 'settings/settings.dart';
import 'wallet/wallet.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WalletController(), permanent: true);
    Get.put(SettingsController(), permanent: true);
    Get.put(NetworkController(), permanent: true);
    Get.put(AddressesBookController(), permanent: true);
  }
}
