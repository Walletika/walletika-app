import '../utils/currency_format.dart';

class TransactionItemModel {
  final String txHash;
  final String txHashURL;
  final String imageURL;
  final String functionName;
  final DateTime date;
  final String symbol;
  final double amount;

  TransactionItemModel({
    required this.txHash,
    required this.txHashURL,
    required this.imageURL,
    required this.functionName,
    required this.date,
    required this.symbol,
    required this.amount,
  });

  String get amountAsCurrency {
    return convertToCoinFormat(value: amount, symbol: symbol);
  }
}
