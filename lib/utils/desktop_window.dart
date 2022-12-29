import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'constants.dart';

Future<void> initDesktopWindow() async {
  if (AppInfo.isDesktop) {
    await WindowManager.instance.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setSize(const Size(400.0, 650.0));
      await windowManager.setMinimumSize(const Size(350.0, 500.0));
      await windowManager.setMaximumSize(const Size(800.0, 1000.0));
      await windowManager.setMaximizable(false);
      await windowManager.center();
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
