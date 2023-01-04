import 'package:get/get.dart';

import '../../models/address_book.dart';
import '../../repositories/addresses_book/fake_repo.dart';
import '../../repositories/addresses_book/repo.dart';

class AddressesBookController extends GetxController {
  // Data repository
  final AddressesBookRepository _repository = AddressesBookFakeRepository();

  // States
  final RxList<AddressBookItemModel> _addressesBook =
      <AddressBookItemModel>[].obs;

  // Event methods
  @override
  void onInit() async {
    await addressesBookUpdate();
    super.onInit();
  }

  // Getter methods
  List<AddressBookItemModel> get addressesBook => _addressesBook;

  bool usernameExists(String username) {
    username = username.toLowerCase();
    return _addressesBook.any(
      (addr) => addr.username.toLowerCase() == username,
    );
  }

  bool addressExists(String address) {
    address = address.toLowerCase();
    return _addressesBook.any(
      (addr) => addr.address.toLowerCase() == address,
    );
  }

  // Setter & Controller methods
  Future<void> addressesBookUpdate() async {
    final List<AddressBookItemModel> result = [];

    await for (final AddressBookItemModel address in _repository.getAll()) {
      result.add(address);
    }

    _addressesBook.value = result;
  }

  Future<bool> addNew({
    required String username,
    required String address,
  }) async {
    final bool isValid = await _repository.addNew(
      username: username,
      address: address,
    );

    if (isValid) await addressesBookUpdate();

    return isValid;
  }

  Future<bool> remove(AddressBookItemModel address) async {
    final bool isValid = await _repository.remove(address);

    if (isValid) await addressesBookUpdate();

    return isValid;
  }
}
