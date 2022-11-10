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

  // Event methods
  @override
  void onInit() async {
    await walletsUpdate();
    super.onInit();
  }

  // Getter methods
  List<WalletItemModel> get wallets => _wallets;

  bool get isSearching => _isSearching.value;

  int count() => _repository.count();

  Future<void> walletsUpdate([String search = '']) async {
    _isSearching.value = search.isNotEmpty;
    search = search.toLowerCase();

    _wallets.value = [
      await for (WalletEngine engine in _repository.getAll())
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
  }

  Future<void> setFavorite(String address) async {
    await _repository.setFavorite(address);
    await walletsUpdate();
  }
}
