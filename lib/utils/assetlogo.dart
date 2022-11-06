import 'dart:io';

Future<String> assetLogo(String symbol) async {
  String path = 'assets/coins/${symbol.toLowerCase()}.png';

  if (!await File(path).exists()) {
    path = 'assets/coins/unknown.png';
  }

  return path;
}
