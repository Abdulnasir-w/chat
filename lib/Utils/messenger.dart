import 'package:url_launcher/url_launcher.dart';

void launchMessenger({required String messengerUrl}) async {
  final Uri url = Uri.parse(messengerUrl.toString());
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  } catch (e) {
    throw "$e";
  }
}
