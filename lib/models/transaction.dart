import '../utils/currency_format.dart';
import 'token.dart';

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

class TransactionDetailsModel {
  final String requestName;
  final String toAddress;
  final Map<String, dynamic> tx;
  final Map<String, dynamic> abi;
  final Map<String, dynamic> args;
  final TokenItemModel coin;
  final TokenItemModel token;
  final double amount;
  final double estimatedGas;
  final double total;

  TransactionDetailsModel({
    required this.requestName,
    required this.toAddress,
    required this.abi,
    required this.tx,
    required this.args,
    required this.coin,
    required this.token,
    required this.amount,
    required this.estimatedGas,
    required this.total,
  });

  String get amountAsCurrency {
    return convertToCoinFormat(value: amount, symbol: token.symbol);
  }

  double? get amountInFiat {
    if (token.price == null) return null;
    return token.price! * amount;
  }

  String get amountInFiatAsCurrency {
    return '≈${convertToFiatFormat(
      value: amountInFiat,
      symbol: token.fiatSymbol,
    )}';
  }

  String get estimatedGasAsCurrency {
    return convertToCoinFormat(value: estimatedGas, symbol: coin.symbol);
  }

  double? get estimatedGasInFiat {
    if (coin.price == null) return null;
    return coin.price! * estimatedGas;
  }

  String get estimatedGasInFiatAsCurrency {
    return '≈${convertToFiatFormat(
      value: estimatedGasInFiat,
      symbol: coin.fiatSymbol,
      skipSmallValue: false,
    )}';
  }

  String get totalAsCurrency {
    return convertToCoinFormat(value: total, symbol: coin.symbol);
  }

  double? get totalInFiat {
    double? value = estimatedGasInFiat;

    if (value != null && amountInFiat != null) {
      value += amountInFiat!;
    }

    return value;
  }

  String get totalInFiatAsCurrency {
    return '≈${convertToFiatFormat(
      value: totalInFiat,
      symbol: coin.fiatSymbol,
      skipSmallValue: false,
    )}';
  }

  TransactionDetailsModel copyWith({
    String? requestName,
    String? toAddress,
    Map<String, dynamic>? tx,
    Map<String, dynamic>? abi,
    Map<String, dynamic>? args,
    TokenItemModel? coin,
    TokenItemModel? token,
    double? amount,
    double? estimatedGas,
    double? total,
  }) {
    return TransactionDetailsModel(
      requestName: requestName ?? this.requestName,
      toAddress: toAddress ?? this.toAddress,
      tx: tx ?? this.tx,
      abi: abi ?? this.abi,
      args: args ?? this.args,
      coin: coin ?? this.coin,
      token: token ?? this.token,
      amount: amount ?? this.amount,
      estimatedGas: estimatedGas ?? this.estimatedGas,
      total: total ?? this.total,
    );
  }
}
