import 'package:get/get.dart';
import 'package:walletika/models/token.dart';

class WithdrawController extends GetxController {
  // States
  final Rxn<TokenItemModel> _token = Rxn<TokenItemModel>();

  // Local data
  String? _toAddress;
  double? _amount;

  // Getter methods
  TokenItemModel get token => _token.value!;

  String? get toAddress => _toAddress;

  double? get amount => _amount;

  // Setter & Controller methods
  void setToken(TokenItemModel token) {
    _token.value = token;
  }

  void setToAddress(String address) {
    _toAddress = address;
  }

  void setAmount(String amount) {
    _amount = double.parse(amount);
  }
}
