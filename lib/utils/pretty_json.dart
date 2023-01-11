import 'dart:convert';

String prettyJson(dynamic json) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(json);
}
