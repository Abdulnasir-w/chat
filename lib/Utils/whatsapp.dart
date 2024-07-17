import 'package:url_launcher/url_launcher.dart';

Future<void> launchWhatsapp({required String phone}) async {
  final url = "https://wa.me/$phone";
  try {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could Not Launch";
    }
  } catch (e) {
    print("Error launching WhatsApp: $e");
  }
}
