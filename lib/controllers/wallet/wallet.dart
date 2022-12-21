import 'package:get/get.dart';

import '../../models/token.dart';
import '../../models/transaction.dart';
import '../../models/wallet.dart';
import '../../repositories/wallet/fake_repo.dart';
import '../../repositories/wallet/repo.dart';
import '../../utils/process_state.dart';

class WalletController extends GetxController {
  // Data repository
  final WalletRepository _repository = WalletFakeRepository();

  // States
  final RxList<WalletViewModel> _wallets = <WalletViewModel>[].obs;
  final RxList<TokenItemModel> _tokens = <TokenItemModel>[].obs;
  final RxList<TransactionItemModel> _transactions =
      <TransactionItemModel>[].obs;
  final RxDouble _totalBalance = 0.0.obs;

  // Process States
  final ProcessState _setFavoriteState = ProcessState();

  // Local Data
  WalletViewModel? _currentWallet;

  // Event methods
  @override
  void onInit() async {
    await walletsUpdate();
    super.onInit();
  }

  // Getter methods
  List<WalletViewModel> get wallets => _wallets;

  List<TokenItemModel> get tokens => _tokens;

  List<TransactionItemModel> get transactions => _transactions;

  double get totalBalance => _totalBalance.value;

  WalletViewModel? get currentWallet => _currentWallet;

  int count() => _repository.count();

  String currentWalletExplorerURL() {
    return _repository.explorerURL(currentWallet!.address);
  }

  bool usernameExists(String username) => _wallets.any(
        (wallet) => wallet.username == username,
      );

  bool tokenExists(String contractAddress) => _tokens.any(
        (token) => token.address == contractAddress,
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

  Future<bool> removeCurrentWallet() async {
    final bool isValid = await _repository.remove(currentWallet!);

    if (isValid) await walletsUpdate();

    return isValid;
  }

  void setCurrentWallet(WalletViewModel wallet) {
    if (wallet == _currentWallet) return;

    _currentWallet = wallet;
    tokensUpdate();
    transactionsUpdate();
  }

  Future<bool> loginValidate(String password) async {
    final bool isValid = await _repository.loginValidate(
      currentWallet: _currentWallet!,
      password: password,
    );

    return isValid;
  }

  Future<bool> login({
    required String password,
    required String otpCode,
  }) async {
    final bool isValid = await _repository.login(
      currentWallet: _currentWallet!,
      password: password,
      otpCode: otpCode,
    );

    if (isValid) await walletsUpdate();

    return isValid;
  }

  Future<String?> getPrivateKey(String otpCode) async {
    return _repository.getPrivateKey(otpCode);
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

  Future<void> tokensUpdate() async {
    if (_currentWallet == null) return;

    _tokens.value = await _repository.tokens(_currentWallet!);

    double balance = 0;
    for (final TokenItemModel token in _tokens) {
      balance += token.balanceInFiat ?? 0;
    }

    _totalBalance.value = balance;
  }

  Future<void> addToken(TokenItemModel token) async {
    await _repository.addToken(token);
    await tokensUpdate();
  }

  Future<bool> removeToken(TokenItemModel token) async {
    final bool isValid = await _repository.removeToken(token);

    if (isValid) await tokensUpdate();

    return isValid;
  }

  Future<void> transactionsUpdate() async {
    if (_currentWallet == null) return;
    _transactions.value = await _repository.transactions(_currentWallet!).then(
          (transactions) => transactions.reversed.take(50).toList(),
        );
  }
}
