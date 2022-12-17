import '../../models/token.dart';
import 'repo.dart';

class AddTokenFakeRepository extends AddTokenRepository {
  @override
  Future<TokenItemModel?> search(String contractAddress) async {
    await Future.delayed(const Duration(seconds: 5));

    if (contractAddress == '0x4fabb145d64652a948d72533023f6e7a623c7c53') {
      return TokenItemModel(
        imageURL:
            'https://assets.coingecko.com/coins/images/9576/small/BUSD.png?1568947766',
        name: 'Binance USD',
        address: contractAddress,
        symbol: 'BUSD',
        decimals: 18,
        changeIn24h: -0.02,
        price: 0.9998,
        balance: 10000.0,
        balanceInFiat: 9998.0,
      );
    }

    return null;
  }
}