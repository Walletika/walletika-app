import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import '../../models/token.dart';
import '../../models/transaction.dart';
import '../../models/wallet.dart';
import '../../repositories/wallet/fake_repo.dart';
import '../../repositories/wallet/repo.dart';

class WalletController extends GetxController {
  // Data repository
  final WalletRepository _repository = WalletFakeRepository();

  // States
  final RxList<WalletItemModel> _wallets = <WalletItemModel>[].obs;
  final RxList<TokenItemModel> _tokens = <TokenItemModel>[].obs;
  final RxList<TransactionItemModel> _transactions =
      <TransactionItemModel>[].obs;
  final RxDouble _totalBalance = 0.0.obs;
  final RxInt _progressValue = 0.obs;
  final RxBool _isBalanceVisible = true.obs;

  // Local Data
  WalletItemModel? _currentWallet;

  // Event methods
  @override
  void onInit() async {
    await walletsUpdate();
    super.onInit();
  }

  // Getter methods
  List<WalletItemModel> get wallets => _wallets;

  List<TokenItemModel> get tokens => _tokens;

  List<TransactionItemModel> get transactions => _transactions;

  double get totalBalance => _totalBalance.value;

  int get progressValue => _progressValue.value;

  bool get isBalanceVisible => _isBalanceVisible.value;

  WalletItemModel? get currentWallet => _currentWallet;

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
    final List<WalletItemModel> result = [];

    await for (final WalletItemModel wallet in _repository.getAll()) {
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

  void setCurrentWallet(WalletItemModel wallet) {
    if (wallet == _currentWallet) return;

    _currentWallet = wallet;
    tokensUpdate();
    transactionsUpdate();
  }

  Future<bool> loginValidate(String password) async {
    final bool isValid = await _repository.loginValidate(
      wallet: _currentWallet!,
      password: password,
    );

    return isValid;
  }

  Future<bool> login({
    required String password,
    required String otpCode,
  }) async {
    final bool isValid = await _repository.login(
      wallet: _currentWallet!,
      password: password,
      otpCode: otpCode,
    );

    if (isValid) await walletsUpdate();

    return isValid;
  }

  Future<void> logout() async {
    await _repository.logout(_currentWallet!);
    await walletsUpdate();
  }

  Future<String?> getPrivateKey(String otpCode) async {
    return _repository.getPrivateKey(wallet: _currentWallet!, otpCode: otpCode);
  }

  Future<void> setFavorite({
    required String search,
    required WalletItemModel wallet,
  }) async {
    await _repository.setFavorite(wallet);
    await walletsUpdate(search);
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
    await _repository.addToken(wallet: _currentWallet!, token: token);
    await tokensUpdate();
  }

  Future<bool> removeToken(TokenItemModel token) async {
    final bool isValid = await _repository.removeToken(
      wallet: _currentWallet!,
      token: token,
    );

    if (isValid) await tokensUpdate();

    return isValid;
  }

  Future<void> transactionsUpdate() async {
    if (_currentWallet == null) return;
    _transactions.value = await _repository.transactions(_currentWallet!).then(
          (transactions) => transactions.reversed.take(50).toList(),
        );
  }

  Future<TransactionDetailsModel> transfer({
    required String recipientAddress,
    required TokenItemModel token,
    required double amount,
  }) async {
    return _repository.transfer(
      wallet: _currentWallet!,
      recipientAddress: recipientAddress,
      token: token,
      amount: amount,
    );
  }

  Future<TransactionDetailsModel> gasUpdate() async {
    return _repository.addGas();
  }

  Future<String> backup({
    required String directory,
    String? password,
  }) async {
    _progressValue.value = 0;

    return await _repository.backup(
      directory: directory,
      password: password,
      progressCallback: _progressCallback,
    );
  }

  Future<bool> import({
    required String path,
    String? password,
  }) async {
    _progressValue.value = 0;

    return _repository.import(
      path: path,
      password: password,
      progressCallback: _progressCallback,
    );
  }

  void balanceVisible(bool state) => _isBalanceVisible.value = state;

  void _progressCallback(value) {
    windowManager.setProgressBar(value / 100);
    _progressValue.value = value;
  }
}
