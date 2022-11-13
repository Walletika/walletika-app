import 'package:flutter/material.dart';

import '../../utils/constants.dart';

SizedBox horizontalSpace([double value = AppDecoration.space]) =>
    SizedBox(width: value);

SizedBox verticalSpace([double value = AppDecoration.space]) =>
    SizedBox(height: value);

SizedBox zeroSpace() => const SizedBox(width: 0, height: 0);
