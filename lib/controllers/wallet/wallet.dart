import 'package:get/get.dart';

import '../../models/wallet.dart';
import '../../repositories/wallet/fake_repo.dart';
import '../../repositories/wallet/repo.dart';
import '../../utils/process_state.dart';

class WalletController extends GetxController {
  // Data repository
  final WalletRepository _repository = WalletFakeRepository();

  // States
  final RxList<WalletViewModel> _wallets = <WalletViewModel>[].obs;

  // Process States
  final ProcessState _setFavoriteState = ProcessState();

  // Local Data
  late WalletViewModel _currentWallet;

  // Event methods
  @override
  void onInit() async {
    await walletsUpdate();
    super.onInit();
  }

  // Getter methods
  List<WalletViewModel> get wallets => _wallets;

  WalletViewModel get currentWallet => _currentWallet;

  int count() => _repository.count();

  bool usernameExists(String username) => _wallets.any(
        (wallet) => wallet.username == username,
      );

  // Setter & Controller methods
  Future<void> walletsUpdate([String search = '']) async {
    search = search.toLowerCase();
    final List<WalletViewModel> result = [];

    await for (final WalletViewModel wallet in _repository.getAll()) {
      if (search.isEmpty ||
          wallet.username.toLowerCase().contains(search) ||
          wallet.address.toLowerCase().contains(search)) {
        result.insert(wallet.isFavorite ? 0 : result.length, wallet);
      }
    }

    _wallets.value = result;
  }

  Future<bool> addNew({
    required String username,
    required String password,
    required String securityPassword,
  }) async {
    final bool isValid = await _repository.addNew(
      username: username,
      password: password,
      securityPassword: securityPassword,
    );

    if (isValid) {
      await walletsUpdate();
      setCurrentWallet(
        _wallets.firstWhere((wallet) => wallet.username == username),
      );
    }

    return isValid;
  }

  void setCurrentWallet(WalletViewModel wallet) {
    _currentWallet = wallet;
  }

  Future<bool> loginValidate(String password) async {
    final bool isValid = await _repository.loginValidate(
      currentWallet: _currentWallet,
      password: password,
    );

    return isValid;
  }

  Future<bool> login({
    required String password,
    required String otpCode,
  }) async {
    final bool isValid = await _repository.login(
      currentWallet: _currentWallet,
      password: password,
      otpCode: otpCode,
    );

    if (isValid) await walletsUpdate();

    return isValid;
  }

  Future<void> setFavorite({
    required String search,
    required WalletViewModel walletViewModel,
  }) async {
    if (!_setFavoriteState.run()) return;

    try {
      await _repository.setFavorite(walletViewModel);
      await walletsUpdate(search);
    } catch (e) {
      rethrow;
    } finally {
      _setFavoriteState.done();
    }
  }
}
