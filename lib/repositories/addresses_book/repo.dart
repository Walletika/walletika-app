import '../../models/address_book.dart';

abstract class AddressesBookRepository {
  Stream<AddressBookItemModel> getAll();

  Future<bool> addNew({
    required String username,
    required String address,
  });

  Future<bool> remove(AddressBookItemModel address);
}
