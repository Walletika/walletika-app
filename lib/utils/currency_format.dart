import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

String convertToFiatFormat({
  double? value,
  required String symbol,
  String nullFormat = '--',
}) {
  if (value == null) return nullFormat;

  if (value < 1) return '$symbol${value == 0 ? '0' : value.toString()}';

  return CurrencyTextInputFormatter(
    symbol: symbol,
    decimalDigits: 2,
  ).format(value.toStringAsFixed(2));
}

String convertToCoinFormat({
  double? value,
  required String symbol,
  String nullFormat = '--',
}) {
  if (value == null) return nullFormat;

  if (value < 1000) return '${value == 0 ? '0' : value.toString()} $symbol';

  String result = CurrencyTextInputFormatter(
    symbol: '',
    decimalDigits: 8,
  ).format(value.toStringAsFixed(8));

  try {
    List<String> digits = result.split('.');
    digits[1] = double.parse('0.${digits[1]}').toString().substring(1);
    result = digits.join();
  } catch (_) {
    // skip
  }

  return '$result $symbol';
}
