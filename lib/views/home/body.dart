import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet_manager.dart';
import '../../models/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/container.dart';
import '../widgets/empty_page.dart';
import '../widgets/spacer.dart';
import '../widgets/wallet_item.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key}) {
    _searchInputController.addListener(_searchOnChanged);
  }

  final TextEditingController _searchInputController = TextEditingController();
  final FocusNode _focusController = FocusNode();
  final WalletManagerController _walletManagerController =
      Get.find<WalletManagerController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search input
        ContainerWithShadow(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                  controller: _searchInputController,
                  focusNode: _focusController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(LineIcons.search),
                    label: Text("1005@global".tr),
                    suffixIcon: Obx(() {
                      return _walletManagerController.isSearching
                          ? IconButton(
                              onPressed: () => _searchInputController.clear(),
                              icon: const Icon(
                                LineIcons.times,
                                size: AppDecoration.iconSmallSize,
                              ),
                            )
                          : zeroSpace();
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        // List view
        Expanded(
          child: Obx(() {
            // No data view
            if (_walletManagerController.wallets.isEmpty) {
              if (_walletManagerController.count() == 0) {
                return EmptyPage(
                  illustrationPath: AppImages.coinIllustrations,
                  title: "1001@home".tr,
                  desc: "1002@home".tr,
                );
              }

              return const Center(child: CircularProgressIndicator());
            }

            final List<WalletItemModel> wallets =
                _walletManagerController.wallets;

            // Data view
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                indent: AppDecoration.dividerPadding,
                endIndent: AppDecoration.dividerPadding,
              ),
              itemCount: wallets.length,
              itemBuilder: (context, index) {
                final WalletItemModel wallet = wallets[index];

                return WalletItem(
                  onTap: () {},
                  username: wallet.username,
                  address: wallet.address,
                  isActive: wallet.isLogged,
                  trailing: IconButton(
                    tooltip: "1008@global".tr,
                    onPressed: () {
                      _walletManagerController.setFavorite(
                        search: _searchInputController.text,
                        address: wallet.address,
                      );
                    },
                    icon: Icon(
                      wallet.isFavorite ? LineIcons.starAlt : LineIcons.star,
                      color: wallet.isFavorite ? Colors.orange : null,
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  void _searchOnChanged() {
    final String text = _searchInputController.text;

    _walletManagerController.walletsUpdate(text);
    if (text.isEmpty) _focusController.unfocus();
  }
}
