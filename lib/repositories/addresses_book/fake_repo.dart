import '../../models/address_book.dart';
import 'repo.dart';

class AddressesBookFakeRepository extends AddressesBookRepository {
  final List<AddressBookItemModel> _addressesBook = [
    AddressBookItemModel(
      username: 'Address 1',
      address: '0x70463907F1aEe85619D8C248352d422681E304A1',
    ),
    AddressBookItemModel(
      username: 'Address 2',
      address: '0x81f4300AD8e46e2315A414DE387a23b84e9B8590',
    ),
    AddressBookItemModel(
      username: 'Address 3',
      address: '0x4520c0fb7aC21d52E089e49261FAC3e7424F9045',
    )
  ];

  @override
  Stream<AddressBookItemModel> getAll() async* {
    for (final AddressBookItemModel address in _addressesBook) {
      yield address;
    }
  }

  @override
  Future<bool> addNew({
    required String username,
    required String address,
  }) async {
    if (username == 'error') throw Exception("Error");

    if (username == 'failed') return false;

    _addressesBook.add(
      AddressBookItemModel(
        username: username,
        address: address,
      ),
    );

    return true;
  }

  @override
  Future<bool> remove(AddressBookItemModel address) async {
    if (address.username.contains('error')) throw Exception("Error");

    if (address.username.contains('failed')) return false;

    return _addressesBook.remove(address);
  }
}
