import 'package:get/get.dart';

import '../../models/transaction.dart';

class TransactionController extends GetxController {
  // States
  final RxBool _gasUpdated = true.obs;

  // Local data
  late TransactionDetailsModel _transactionDetails;
  String? _privateKey;

  // Getter methods
  bool get gasUpdated => _gasUpdated.value;

  TransactionDetailsModel get transactionDetails => _transactionDetails;

  String? get privateKey => _privateKey;

  // Setter methods
  void setGasUpdated(bool updated) {
    _gasUpdated.value = updated;
  }

  void setTransactionDetails(TransactionDetailsModel transaction) {
    _transactionDetails = transaction;
  }

  void setPrivateKey(String? privateKey) {
    _privateKey = privateKey;
  }
}
