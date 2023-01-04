import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/addresses_book/addresses_book.dart';
import '../../controllers/tabs/tabs.dart';
import '../../controllers/withdraw/withdraw.dart';
import '../../utils/constants.dart';
import '../widgets/address_field.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/spacer.dart';
import '../widgets/tab_buttons.dart';
import 'addresses_book_tab.dart';
import 'amount.dart';
import 'my_wallets_tab.dart';

class WithdrawBody extends StatefulWidget {
  const WithdrawBody({super.key});

  @override
  State<WithdrawBody> createState() => _WithdrawBodyState();
}

class _WithdrawBodyState extends State<WithdrawBody>
    with TickerProviderStateMixin {
  _WithdrawBodyState() {
    _toAddressController.addListener(_toAddressOnChanged);
  }

  late TabController _tabController;
  final TabsController _tabsController = Get.find<TabsController>(
    tag: AppPages.withdraw,
  );
  final TextEditingController _toAddressController = TextEditingController();
  final WithdrawController _withdrawController = Get.find<WithdrawController>();
  final AddressesBookController _addressesBookController =
      Get.find<AddressesBookController>();

  @override
  void initState() {
    _tabController = TabController(
      length: _tabsController.totalTabs,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppDecoration.paddingBig),
      child: Column(
        children: [
          Text(
            "1000@withdraw".tr,
            style: textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          verticalSpace(),
          AddressFormField(
            controller: _toAddressController,
            placeholderText: "1001@withdraw".tr,
          ),
          verticalSpace(AppDecoration.spaceBig),
          Obx(() {
            return TabButtons(
              tabController: _tabController,
              tabsController: _tabsController,
              maxCount: 99,
              tabs: {
                "1002@withdraw".tr: null,
                "1003@withdraw".tr:
                    _addressesBookController.addressesBook.length,
              },
            );
          }),
          const Divider(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).popupMenuTheme.color,
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  MyWalletsTabView(_toAddressController),
                  AddressesBookTabView(_toAddressController),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toAddressOnChanged() {
    final String text = _toAddressController.text;

    if (text.isNotEmpty) {
      _withdrawController.setToAddress(text);
      buttomSheet(
        widget: AmountView(),
        onCompleted: _toAddressController.clear,
      );
    }
  }
}
