import 'package:flutter/material.dart';

import '../../utils/constants.dart';

const TextStyle _primaryTextStyle = TextStyle(
  color: AppColors.font,
  fontFamily: AppFonts.normal,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.normal,
  letterSpacing: 0,
  overflow: TextOverflow.fade,
);

final TextTheme _textTheme = TextTheme(
  displayLarge: _primaryTextStyle.copyWith(fontSize: 30.0),
  displayMedium: _primaryTextStyle.copyWith(fontSize: 28.0),
  displaySmall: _primaryTextStyle.copyWith(fontSize: 26.0),
  headlineLarge: _primaryTextStyle.copyWith(fontSize: 24.0),
  headlineMedium: _primaryTextStyle.copyWith(fontSize: 22.0),
  headlineSmall: _primaryTextStyle.copyWith(fontSize: 20.0),
  titleLarge: _primaryTextStyle.copyWith(
    fontFamily: AppFonts.bold,
    fontSize: 20.0,
  ),
  titleMedium: _primaryTextStyle.copyWith(
    fontFamily: AppFonts.bold,
    fontSize: 18.0,
  ),
  titleSmall: _primaryTextStyle.copyWith(
    fontFamily: AppFonts.bold,
    fontSize: 16.0,
  ),
  bodyLarge: _primaryTextStyle.copyWith(fontSize: 16.0),
  bodyMedium: _primaryTextStyle.copyWith(fontSize: 14.0),
  bodySmall: _primaryTextStyle.copyWith(fontSize: 12.0),
  labelLarge: _primaryTextStyle.copyWith(
    color: AppColors.font2,
    fontSize: 16.0,
  ),
  labelMedium: _primaryTextStyle.copyWith(
    color: AppColors.font2,
    fontSize: 14.0,
  ),
  labelSmall: _primaryTextStyle.copyWith(
    color: AppColors.font2,
    fontSize: 12.0,
  ),
);

const IconThemeData _iconTheme = IconThemeData(
  color: AppColors.icon,
  size: AppDecoration.iconSize,
);

final ThemeData walletikaDefaultTheme = ThemeData(
  fontFamily: _textTheme.bodyMedium!.fontFamily,
  backgroundColor: AppColors.background,
  scaffoldBackgroundColor: AppColors.background,
  primarySwatch: AppColors.highlightMaterial,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    shadowColor: Colors.black38,
    titleSpacing: 5.0,
    elevation: 0,
    iconTheme: _iconTheme,
  ),
  textTheme: _textTheme,
  iconTheme: _iconTheme,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: _textTheme.labelMedium,
    errorStyle: _textTheme.bodySmall!.copyWith(color: Colors.red),
    filled: true,
    fillColor: AppColors.background2,
    prefixIconColor: _iconTheme.color,
    suffixIconColor: _iconTheme.color,
    counterStyle: _textTheme.labelSmall,
    border: UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(AppDecoration.radius),
    ),
    constraints: const BoxConstraints(maxWidth: AppDecoration.widgetWidth),
  ),
  listTileTheme: ListTileThemeData(
    iconColor: _iconTheme.color,
    minVerticalPadding: AppDecoration.padding,
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.black12,
    space: 1.0,
  ),
  tooltipTheme: const TooltipThemeData(preferBelow: false),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: _textTheme.bodyMedium!.copyWith(fontFamily: AppFonts.medium),
      padding: const EdgeInsets.symmetric(horizontal: AppDecoration.padding),
      minimumSize: const Size(100.0, AppDecoration.buttonHeight),
      maximumSize: const Size(
        AppDecoration.widgetWidth,
        AppDecoration.buttonHeight,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: _textTheme.bodyMedium,
      padding: const EdgeInsets.symmetric(horizontal: AppDecoration.padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.background2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDecoration.radius),
    ),
    textStyle: _textTheme.bodyMedium,
  ),
);

final ThemeData walletikaDarkTheme = walletikaDefaultTheme.copyWith(
  backgroundColor: AppColors.backgroundDark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  appBarTheme: walletikaDefaultTheme.appBarTheme.copyWith(
    backgroundColor: AppColors.backgroundDark,
    shadowColor: Colors.black,
  ),
  textTheme: _textTheme.copyWith(
    displayLarge: _textTheme.displayLarge!.copyWith(
      color: AppColors.fontDark,
    ),
    displayMedium: _textTheme.displayMedium!.copyWith(
      color: AppColors.fontDark,
    ),
    displaySmall: _textTheme.displaySmall!.copyWith(
      color: AppColors.fontDark,
    ),
    headlineLarge: _textTheme.headlineLarge!.copyWith(
      color: AppColors.fontDark,
    ),
    headlineMedium: _textTheme.headlineMedium!.copyWith(
      color: AppColors.fontDark,
    ),
    headlineSmall: _textTheme.headlineSmall!.copyWith(
      color: AppColors.fontDark,
    ),
    titleLarge: _textTheme.titleLarge!.copyWith(
      fontFamily: AppFonts.medium,
      color: AppColors.fontDark,
    ),
    titleMedium: _textTheme.titleMedium!.copyWith(
      fontFamily: AppFonts.medium,
      color: AppColors.fontDark,
    ),
    titleSmall: _textTheme.titleSmall!.copyWith(
      fontFamily: AppFonts.medium,
      color: AppColors.fontDark,
    ),
    bodyLarge: _textTheme.bodyLarge!.copyWith(color: AppColors.fontDark),
    bodyMedium: _textTheme.bodyMedium!.copyWith(color: AppColors.fontDark),
    bodySmall: _textTheme.bodySmall!.copyWith(color: AppColors.fontDark),
  ),
  inputDecorationTheme: walletikaDefaultTheme.inputDecorationTheme.copyWith(
    fillColor: AppColors.background2Dark,
  ),
  scrollbarTheme: walletikaDefaultTheme.scrollbarTheme.copyWith(
    thumbColor: MaterialStateProperty.resolveWith(
      (states) => AppColors.lineDark.withOpacity(0.7),
    ),
  ),
  dividerTheme: walletikaDefaultTheme.dividerTheme.copyWith(
    color: Colors.white10,
  ),
  popupMenuTheme: walletikaDefaultTheme.popupMenuTheme.copyWith(
    color: AppColors.background2Dark,
    textStyle: _textTheme.bodyMedium!.copyWith(color: AppColors.fontDark),
  ),
);
