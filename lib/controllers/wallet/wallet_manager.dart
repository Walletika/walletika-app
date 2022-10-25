import 'package:get/get.dart';
import 'package:walletika_sdk/walletika_sdk.dart';

import '../../models/wallet.dart';
import '../../repositories/wallet/fake_repo.dart';
import '../../repositories/wallet/repo.dart';

class WalletManagerController extends GetxController {
  // Data repository
  final WalletRepository _repository = WalletFakeRepository();

  // States
  final RxList<WalletItemModel> _wallets = <WalletItemModel>[].obs;
  final RxBool _isSearching = false.obs;

  // Local data
  Map<String, WalletEngine> _engines = {};
  int _count = 1; // Start as available items

  // Event methods
  @override
  void onInit() {
    enginesUpdate();
    super.onInit();
  }

  // Getter methods
  List<WalletItemModel> get wallets => _wallets;

  bool get isSearching => _isSearching.value;

  int get count => _count;

  // Setter & Controller methods
  Future<void> enginesUpdate() {
    return _repository.getAll().then((wallets) async {
      _count = wallets.length;
      _wallets.clear();

      _engines = {
        for (WalletModel wallet in wallets)
          wallet.address.hexEip55:
              _engines[wallet.address.hexEip55] ?? WalletEngine(wallet)
      };

      await walletsUpdate();
    });
  }

  Future<void> walletsUpdate([String search = '']) {
    return Future(() {
      _isSearching.value = search.isNotEmpty;
      search = search.toLowerCase();

      _wallets.value = [
        for (WalletEngine engine in _engines.values)
          if (search.isEmpty ||
              engine.username().toLowerCase().contains(search) ||
              engine.address().hex.contains(search))
            WalletItemModel(
              username: engine.username(),
              address: engine.address().hexEip55,
              isFavorite: engine.isFavorite(),
              isLogged: engine.isLogged(),
            )
      ];
    });
  }
}
