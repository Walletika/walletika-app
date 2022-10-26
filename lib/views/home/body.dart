import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/wallet/wallet_manager.dart';
import '../../models/wallet.dart';
import '../../utils/constants.dart';
import '../widgets/address.dart';
import '../widgets/container.dart';
import '../widgets/spacer.dart';

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
                    prefixIcon: const Icon(Icons.search_rounded),
                    label: Text("1005@global".tr),
                    suffixIcon: Obx(() {
                      return _walletManagerController.isSearching
                          ? IconButton(
                              onPressed: () => _searchInputController.clear(),
                              icon: const Icon(Icons.clear_rounded),
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
              if (_walletManagerController.count == 0) {
                return Padding(
                  padding: const EdgeInsets.all(AppDecoration.padding),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 8,
                        child: Image.asset(
                          AppImages.coinIllustrations,
                          filterQuality: FilterQuality.medium,
                          isAntiAlias: true,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "1001@home".tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "1002@home".tr,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }

            final List<WalletItemModel> wallets =
                _walletManagerController.wallets;

            // Data view
            return ListView.builder(
                itemCount: wallets.length,
                itemBuilder: (context, index) {
                  final WalletItemModel wallet = wallets[index];

                  return ListTile(
                    onTap: () {},
                    leading: const Icon(
                      LineIcons.wallet,
                      size: 50.0,
                      color: AppColors.highlight,
                    ),
                    title: Text(
                      wallet.username,
                      softWrap: false,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: TextAddress(wallet.address, height: 30.0),
                    trailing: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            wallet.isFavorite ? Icons.star : Icons.star_border,
                            color: wallet.isFavorite ? Colors.orange : null,
                          ),
                        ),
                        Icon(
                          Icons.online_prediction,
                          color: wallet.isLogged ? Colors.green : null,
                        ),
                      ],
                    ),
                  );
                });
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
