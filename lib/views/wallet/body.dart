import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/tabs/tabs.dart';
import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../../utils/currency_format.dart';
import '../widgets/spacer.dart';
import 'coins_tab.dart';
import 'transactions_tab.dart';
import '../add_token/add_token.dart';

enum MenuOptions { walletDetails, addToken, viewAtExplorer, removeWallet, lock }

class WalletBody extends StatefulWidget {
  const WalletBody({super.key});

  @override
  State<WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> with TickerProviderStateMixin {
  late Timer _tokensUpdateTimer;
  late TabController _tabController;
  final TabsController _tabsController = Get.find<TabsController>();
  final WalletController _walletController = Get.find<WalletController>();

  @override
  void initState() {
    _tabController = TabController(
      length: _tabsController.totalTabs,
      vsync: this,
    );
    _tokensUpdateTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _walletController.tokensUpdate();
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tokensUpdateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Center(
              child: Text(
                _walletController.currentWallet!.username,
                softWrap: false,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            PopupMenuButton(
              tooltip: "1030@global".tr,
              onSelected: _menuOnSelected,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: MenuOptions.walletDetails,
                  child: Text("1006@wallet".tr),
                ),
                PopupMenuItem(
                  value: MenuOptions.addToken,
                  child: Text("1007@wallet".tr),
                ),
                PopupMenuItem(
                  value: MenuOptions.viewAtExplorer,
                  child: Text("1008@wallet".tr),
                ),
                PopupMenuItem(
                  value: MenuOptions.removeWallet,
                  child: Text("1009@wallet".tr),
                ),
                PopupMenuItem(
                  value: MenuOptions.lock,
                  child: Text("1010@wallet".tr),
                ),
              ],
            ),
          ],
        ),
        verticalSpace(),
        Text(
          "1000@wallet".tr,
          softWrap: false,
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
        Obx(() {
          return Text(
            convertToFiatFormat(
              value: _walletController.totalBalance,
              symbol: '\$',
            ),
            softWrap: false,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          );
        }),
        Padding(
          padding: const EdgeInsets.all(AppDecoration.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  height: AppDecoration.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(AppDecoration.radius),
                        ),
                      ),
                    ),
                    child: Text("1001@wallet".tr),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: AppDecoration.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text("1002@wallet".tr),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: AppDecoration.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(AppDecoration.radius),
                        ),
                      ),
                    ),
                    child: Text("1003@wallet".tr),
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).popupMenuTheme.color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
          ),
          child: Obx(() {
            final int tabIndex = _tabsController.currentTabIndex;
            const Border border = Border(
              bottom: BorderSide(color: AppColors.highlight, width: 3.0),
            );

            return Row(children: [
              Expanded(
                child: SizedBox(
                  height: AppDecoration.buttonHeightLarge,
                  child: Material(
                    color: Colors.transparent,
                    shape: tabIndex == 0 ? border : null,
                    child: TextButton(
                      onPressed: () => _tabController.animateTo(
                        _tabsController.toPreviousTab(),
                      ),
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "1004@wallet".tr,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                              fontFamily: AppFonts.medium,
                              color: tabIndex == 0 ? AppColors.highlight : null,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: AppDecoration.buttonHeightLarge,
                  child: Material(
                    color: Colors.transparent,
                    shape: tabIndex == 1 ? border : null,
                    child: TextButton(
                      onPressed: () => _tabController.animateTo(
                        _tabsController.toNextTab(),
                      ),
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "1005@wallet".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    fontFamily: AppFonts.medium,
                                    color: tabIndex == 1
                                        ? AppColors.highlight
                                        : null,
                                  ),
                            ),
                          ),
                          horizontalSpace(),
                          Obx(() {
                            final int count =
                                _walletController.transactions.length;

                            return Container(
                              width: 25.0,
                              height: 15.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: tabIndex == 1
                                    ? AppColors.highlight
                                    : AppColors.font2,
                                borderRadius: BorderRadius.circular(
                                  AppDecoration.radius,
                                ),
                              ),
                              child: Text(
                                count >= 50 ? '+50' : count.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontFamily: AppFonts.light,
                                      fontSize: 10.0,
                                      color: Colors.white,
                                    ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          }),
        ),
        const Divider(),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).popupMenuTheme.color,
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                CoinsTabView(),
                TransactionsTabView(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _menuOnSelected(MenuOptions value) {
    switch (value) {
      case MenuOptions.walletDetails:
        Get.toNamed(AppPages.walletDetails);
        break;
      case MenuOptions.addToken:
        _bottomSheet(const AddTokenView());
        break;
      default:
    }
  }

  void _bottomSheet(Widget widget) {
    Get.bottomSheet(
      widget,
      backgroundColor: Theme.of(context).backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
    );
  }
}
