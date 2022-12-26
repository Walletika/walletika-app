import 'package:get/get.dart';

import '../../models/token.dart';
import '../../repositories/add_token/fake_repo.dart';
import '../../repositories/add_token/repo.dart';

class AddTokenController extends GetxController {
  // Data repository
  final AddTokenRepository _repository = AddTokenFakeRepository();

  // States
  final Rxn<TokenItemModel> _token = Rxn<TokenItemModel>();
  final RxBool _isSearching = false.obs;

  // Getter methods
  TokenItemModel? get token => _token.value;

  bool get isSearching => _isSearching.value;

  Future<bool> search(String contractAddress) async {
    _isSearching.value = true;

    try {
      _token.value = await _repository.search(contractAddress);
    } catch (_) {
      rethrow;
    } finally {
      _isSearching.value = false;
    }

    return _token.value != null;
  }
}
