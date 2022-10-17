import 'package:flutter/material.dart';

import '../../utils/constants.dart';

const TextStyle _primaryTextStyle = TextStyle(
  color: AppColors.font,
  overflow: TextOverflow.fade,
);

TextStyle _primaryTextStyleDark = _primaryTextStyle.copyWith(
  color: AppColors.fontDark,
);

TextStyle _secondaryTextStyle = _primaryTextStyle.copyWith(
  color: AppColors.font2,
);

ThemeData walletikaDefaultTheme = ThemeData(
  fontFamily: AppFonts.normal,
  backgroundColor: AppColors.background,
  scaffoldBackgroundColor: AppColors.background,
  primarySwatch: AppColors.highlightMaterial,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    shadowColor: Colors.black38,
    titleSpacing: 5.0,
    elevation: AppDecoration.elevation,
    iconTheme: IconThemeData(
      color: AppColors.icon,
      size: AppDecoration.iconSize,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: _primaryTextStyle,
    displayMedium: _primaryTextStyle,
    displaySmall: _primaryTextStyle,
    headlineLarge: _primaryTextStyle,
    headlineMedium: _primaryTextStyle,
    headlineSmall: _primaryTextStyle,
    titleLarge: _primaryTextStyle,
    titleMedium: _primaryTextStyle,
    titleSmall: _primaryTextStyle,
    bodyLarge: _primaryTextStyle,
    bodyMedium: _primaryTextStyle,
    bodySmall: _secondaryTextStyle,
    labelLarge: _secondaryTextStyle,
    labelMedium: _secondaryTextStyle,
    labelSmall: _secondaryTextStyle,
  ),
  iconTheme: const IconThemeData(
    color: AppColors.icon,
    size: AppDecoration.iconSize,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: _secondaryTextStyle,
    filled: true,
    fillColor: AppColors.background2,
    prefixIconColor: AppColors.icon,
    suffixIconColor: AppColors.icon,
    border: UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(AppDecoration.radius),
    ),
    constraints: const BoxConstraints(maxWidth: 350.0),
  ),
);

ThemeData walletikaDarkTheme = walletikaDefaultTheme.copyWith(
  backgroundColor: AppColors.backgroundDark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  appBarTheme: walletikaDefaultTheme.appBarTheme.copyWith(
    backgroundColor: AppColors.backgroundDark,
    shadowColor: Colors.black,
  ),
  textTheme: walletikaDefaultTheme.textTheme.copyWith(
    displayLarge: _primaryTextStyleDark,
    displayMedium: _primaryTextStyleDark,
    displaySmall: _primaryTextStyleDark,
    headlineLarge: _primaryTextStyleDark,
    headlineMedium: _primaryTextStyleDark,
    headlineSmall: _primaryTextStyleDark,
    titleLarge: _primaryTextStyleDark,
    titleMedium: _primaryTextStyleDark,
    titleSmall: _primaryTextStyleDark,
    bodyLarge: _primaryTextStyleDark,
    bodyMedium: _primaryTextStyleDark,
  ),
  inputDecorationTheme: walletikaDefaultTheme.inputDecorationTheme.copyWith(
    fillColor: AppColors.background2Dark,
  ),
);
