import 'package:get/get.dart';
import 'package:walletika_sdk/walletika_sdk.dart';

import '../../models/wallet.dart';
import '../../repositories/wallet/fake_repo.dart';
import '../../repositories/wallet/repo.dart';
import '../../utils/process_state.dart';

class WalletManagerController extends GetxController {
  // Data repository
  final WalletRepository _repository = WalletFakeRepository();

  // States
  final RxList<WalletItemModel> _wallets = <WalletItemModel>[].obs;

  // Process States
  final ProcessState _setFavoriteState = ProcessState();

  // Local Data
  late WalletItemModel _currentWallet;

  // Event methods
  @override
  void onInit() async {
    await walletsUpdate();
    super.onInit();
  }

  // Getter methods
  List<WalletItemModel> get wallets => _wallets;

  WalletItemModel get currentWallet => _currentWallet;

  int count() => _repository.count();

  bool usernameExists(String username) => _wallets.any(
        (wallet) => wallet.username == username,
      );

  // Setter & Controller methods
  void setCurrentWallet(String address) {
    for (WalletItemModel wallet in _wallets) {
      if (wallet.address == address) {
        _currentWallet = wallet;
        break;
      }
    }
  }

  Future<void> walletsUpdate([String search = '']) async {
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

  Future<bool> addNew({
    required String username,
    required String password,
    required String securityPassword,
  }) async {
    final bool result = await _repository.addNew(
      username: username,
      password: password,
      securityPassword: securityPassword,
    );
    await walletsUpdate();

    return result;
  }

  Future<bool> loginValidate(String password) async {
    return await _repository.loginValidate(
      address: currentWallet.address,
      password: password,
    );
  }

  Future<bool> login({
    required String password,
    required String otpCode,
  }) async {
    final bool isValid = await _repository.login(
      address: currentWallet.address,
      password: password,
      otpCode: otpCode,
    );

    if (isValid) await walletsUpdate();

    return isValid;
  }

  Future<void> setFavorite({
    required String search,
    required String address,
  }) async {
    if (!_setFavoriteState.run()) return;

    try {
      await _repository.setFavorite(address);
      await walletsUpdate(search);
    } catch (e) {
      rethrow;
    } finally {
      _setFavoriteState.done();
    }
  }
}
