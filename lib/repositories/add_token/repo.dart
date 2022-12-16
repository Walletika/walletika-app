import '../../models/token.dart';

abstract class AddTokenRepository {
  Future<TokenItemModel?> search(String contractAddress);
}
