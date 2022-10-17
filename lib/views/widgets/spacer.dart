import 'package:flutter/material.dart';

SizedBox horizontalSpace([double value = 10.0]) => SizedBox(width: value);

SizedBox verticalSpace([double value = 10.0]) => SizedBox(height: value);

SizedBox zeroSpace() => const SizedBox(width: 0, height: 0);
