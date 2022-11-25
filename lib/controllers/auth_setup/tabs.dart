import 'package:get/get.dart';

class TabsController extends GetxController {
  // States
  final RxInt _currentTabIndex = 0.obs;

  // Local Data
  static const int _totalTabs = 4;

  // Getter methods
  int get currentTabIndex => _currentTabIndex.value;

  // Setter & Controller methods
  int toNextTab() {
    if (_currentTabIndex.value < _totalTabs - 1) _currentTabIndex.value++;
    return _currentTabIndex.value;
  }

  int toPreviousTab() {
    if (_currentTabIndex.value > 0) _currentTabIndex.value--;
    return _currentTabIndex.value;
  }
}
