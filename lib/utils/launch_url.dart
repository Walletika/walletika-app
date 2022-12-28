import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../views/widgets/operation_notifier.dart';

Future<void> launchURL(String url) async {
  final OperationNotifier operation = OperationNotifier(id: "0xeA152Fbc");
  Uri uri = Uri.parse(url);

  return operation.run(
    callback: () async {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return true;
      }

      throw Exception("${"1036@global".tr}: $url");
    },
  );
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
