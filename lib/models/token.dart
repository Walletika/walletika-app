import '../utils/currency_format.dart';

class TokenItemModel {
  final String imageURL;
  final String name;
  final String address;
  final String symbol;
  final String faitSymbol;
  final double? changeIn24h;
  final double? price;
  final double? balance;
  final double? balanceInFiat;

  TokenItemModel({
    required this.imageURL,
    required this.name,
    required this.address,
    required this.symbol,
    this.faitSymbol = '\$',
    this.changeIn24h,
    this.price,
    this.balance,
    this.balanceInFiat,
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
    return convertToFiatFormat(value: balanceInFiat, symbol: faitSymbol);
  }
}
