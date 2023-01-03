import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AmountFormatter extends TextInputFormatter {
  AmountFormatter({
    this.decimalCount = 8,
    this.numberCount = 20,
    this.formatter,
    this.allowNegatives = true,
  }) : super();

  final int decimalCount;
  final int numberCount;
  final bool allowNegatives;
  static final NumberFormat _formatter = NumberFormat.decimalPattern();
  final NumberFormat? formatter;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final decimalSeparator = (formatter ?? _formatter).symbols.DECIMAL_SEP;

    /// Blank string is allowed
    if (newValue.text == "") {
      return newValue;
    }
    if (newValue.text.contains("-") && !allowNegatives) {
      return oldValue;
    }

    try {
      /// Check if the number is parseable.  This throws out anything that would make it invalid i.e. alpha characters.
      final isNotANumber = double.tryParse(newValue.text) == null;
      if (isNotANumber) {
        return oldValue;
      }
    } catch (e) {
      return oldValue;
    }

    /// Check how many decimal characters are in the string.  If more than 2, kick it out.
    final segments = newValue.text.split(decimalSeparator);
    final numberOfDecimal = segments.length;
    if (numberOfDecimal > 2) {
      return oldValue;
    } else {
      /// If we have a decimal
      if (segments.length == 2) {
        /// Check that both the number count and decimal pass
        if (isDecimalPass(segments[1]) && isNumberPass(segments[0])) {
          return newValue;
        }
        return oldValue;
      } else {
        /// If we don't have a decimal, just check that the number passes
        if (isNumberPass(segments[0])) {
          return newValue;
        }
        return oldValue;
      }
    }
  }

  /// checks string against decimal count
  isDecimalPass(String text) {
    if (text.length > decimalCount) {
      return false;
    }
    return true;
  }

  /// checks string against number count
  isNumberPass(String text) {
    if (text.length > numberCount) {
      return false;
    }
    return true;
  }
}
