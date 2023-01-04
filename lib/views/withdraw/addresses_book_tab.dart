import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/addresses_book/addresses_book.dart';
import '../../models/address_book.dart';
import '../../utils/constants.dart';
import '../widgets/dialog.dart';
import '../widgets/empty_page.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/wallet_item.dart';
import 'add_address.dart';

class AddressesBookTabView extends StatelessWidget {
  AddressesBookTabView(this.toAddressController, {super.key});

  final TextEditingController toAddressController;
  final AddressesBookController _addressesBookController =
      Get.find<AddressesBookController>();
  final AddAddressView _addAddressView = AddAddressView();
  final OperationNotifier _removeOperation = OperationNotifier(
    id: "0x4D2b4FEF",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() {
        final List<AddressBookItemModel> addressesBook =
            _addressesBookController.addressesBook;

        if (addressesBook.isEmpty) {
          return Center(
            child: EmptyPage(
              illustrationPath: AppImages.emptyIllustrations,
              title: "1005@withdraw".tr,
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(bottom: AppDecoration.spaceLarge),
          separatorBuilder: (context, index) => const Divider(
            indent: AppDecoration.dividerPadding,
            endIndent: AppDecoration.dividerPadding,
          ),
          itemCount: addressesBook.length,
          itemBuilder: (context, index) {
            final AddressBookItemModel addressBook = addressesBook[index];

            return WalletItem(
              onTap: () => _addressBookOnTap(addressBook),
              username: addressBook.username,
              address: addressBook.address,
              trailing: IconButton(
                onPressed: () => _removeOnPressed(addressBook),
                icon: const Icon(
                  LineIcons.times,
                  size: AppDecoration.iconSmallSize,
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAddressView.addAddressOnPressed,
        tooltip: "1010@withdraw".tr,
        elevation: AppDecoration.elevation,
        child: const Icon(LineIcons.plus),
      ),
    );
  }

  void _addressBookOnTap(AddressBookItemModel address) {
    if (toAddressController.text == address.address) return;

    toAddressController.text = address.address;
  }

  void _removeOnPressed(AddressBookItemModel address) {
    awesomeDialog(
      dialogType: DialogType.warning,
      title: "1006@withdraw".tr,
      desc: "1007@withdraw".tr,
      btnOkText: "1007@global".tr,
      btnOkOnPress: () => _removeAddressBook(address),
    ).show();
  }

  void _removeAddressBook(AddressBookItemModel address) {
    _removeOperation.run(
      callback: () => _addressesBookController.remove(address),
      title: address.username,
      validMessage: "1008@withdraw".tr,
      invalidMessage: "1009@withdraw".tr,
    );
  }
}
