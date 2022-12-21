import '../utils/currency_format.dart';

class TokenItemModel {
  final String imageURL;
  final String explorerURL;
  final String name;
  final String symbol;
  final String faitSymbol;
  final double? changeIn24h;
  final double? price;
  final double? balance;
  final double? balanceInFiat;
  final String? address;
  final int? decimals;

  TokenItemModel({
    required this.imageURL,
    required this.explorerURL,
    required this.name,
    required this.symbol,
    this.faitSymbol = '\$',
    this.changeIn24h,
    this.price,
    this.balance,
    this.balanceInFiat,
    this.address,
    this.decimals,
  });

  String get changeIn24hAsPercentage {
    return '${convertToFiatFormat(
      value: changeIn24h,
      symbol: changeIn24h!.isNegative ? '' : '+',
    )}%';
  }

  String get priceAsCurrency {
    return convertToFiatFormat(value: price, symbol: faitSymbol);
  }

  String get balanceAsCurrency {
    return convertToCoinFormat(value: balance, symbol: symbol);
  }

  String get balanceInFiatAsCurrency {
    return '≈${convertToFiatFormat(value: balanceInFiat, symbol: faitSymbol)}';
  }
}
