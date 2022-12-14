import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/tabs/tabs.dart';
import '../../controllers/wallet/wallet.dart';
import '../../utils/constants.dart';
import '../../utils/currency_format.dart';
import '../../utils/launch_url.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/dialog.dart';
import '../widgets/operation_notifier.dart';
import '../widgets/snackbar.dart';
import '../widgets/spacer.dart';
import '../widgets/tab_buttons.dart';
import 'tokens_tab.dart';
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
  final TabsController _tabsController = Get.find<TabsController>(
    tag: AppPages.wallet,
  );
  final WalletController _walletController = Get.find<WalletController>();
  final OperationNotifier _removeOperation = OperationNotifier(
    id: "0x518705F0",
  );
  final OperationNotifier _logoutOperation = OperationNotifier(
    id: "0xe634FCdd",
  );

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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppDecoration.spaceMedium,
                right: AppDecoration.spaceBig,
              ),
              child: Center(
                child: Text(
                  _walletController.currentWallet!.username,
                  softWrap: false,
                  style: textTheme.bodyLarge!.copyWith(
                    fontFamily: AppFonts.bold,
                  ),
                ),
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
          style: textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        Obx(() {
          final bool visible = _walletController.isBalanceVisible;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                visible
                    ? convertToFiatFormat(
                        value: _walletController.totalBalance,
                        symbol: '\$',
                      )
                    : AppDecoration.invisibleText,
                softWrap: false,
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () => _walletController.balanceVisible(!visible),
                tooltip: "1021@wallet".tr,
                icon: Icon(
                  visible ? LineIcons.eyeSlash : LineIcons.eye,
                  size: AppDecoration.iconSmallSize,
                ),
              ),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.all(AppDecoration.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  height: AppDecoration.buttonHeightMedium,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(AppPages.depsoit),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(AppDecoration.radius),
                        ),
                      ),
                    ),
                    child: Text(
                      "1001@wallet".tr,
                      style: textTheme.bodySmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: AppDecoration.buttonHeightMedium,
                  child: ElevatedButton(
                    onPressed: _withdrawOnPressed,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "1002@wallet".tr,
                      style: textTheme.bodySmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: AppDecoration.buttonHeightMedium,
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
                    child: Text(
                      "1003@wallet".tr,
                      style: textTheme.bodySmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          return TabButtons(
            tabController: _tabController,
            tabsController: _tabsController,
            tabs: {
              "1004@wallet".tr: null,
              "1005@wallet".tr: _walletController.transactions.length,
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
                TokensTabView(),
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
        bottomSheet(widget: const AddTokenView());
        break;
      case MenuOptions.viewAtExplorer:
        launchURL(_walletController.currentWalletExplorerURL());
        break;
      case MenuOptions.removeWallet:
        _removeOnSelected();
        break;
      case MenuOptions.lock:
        _lockOnSelected();
        break;
    }
  }

  void _removeOnSelected() {
    awesomeDialog(
      dialogType: DialogType.warning,
      title: "1009@wallet".tr,
      desc: "1018@wallet".tr,
      btnOkText: "1007@global".tr,
      btnOkOnPress: () => _removeWallet(),
    ).show();
  }

  void _removeWallet() {
    _removeOperation.run(
      callback: () => _walletController.removeCurrentWallet(),
      title: _walletController.currentWallet!.username,
      validMessage: "1019@wallet".tr,
      invalidMessage: "1020@wallet".tr,
      closeScreenWhenValid: true,
    );
  }

  void _lockOnSelected() {
    _logoutOperation.run(
      callback: () => _walletController.logout().then((_) => true),
      onValid: Get.back,
    );
  }

  void _withdrawOnPressed() {
    if (_walletController.currentWallet!.isLogged) {
      Get.toNamed(AppPages.withdraw);
      return;
    }

    modernSnackBar(
      title: "1032@global".tr,
      message: "1033@global".tr,
      isSuccess: false,
    );
  }
}
