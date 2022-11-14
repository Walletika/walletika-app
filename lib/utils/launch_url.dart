import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw Exception("Could not launch $url");
  }
}

String urlCorrection({required String url, String protocol = 'http'}) {
  url = url.replaceAll(' ', '');

  while (url.contains('//')) {
    url = url.replaceAll('//', '/');
  }

  if (url.startsWith('/')) url = url.substring(1, url.length);

  if (url.endsWith('/')) url = url.substring(0, url.length - 1);

  final List<String> urlSplit = url.split(':/');
  if (urlSplit.length == 1) urlSplit.insert(0, protocol);

  return "${urlSplit[0]}://${urlSplit[1]}";
}
