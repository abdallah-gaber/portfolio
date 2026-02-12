import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in the default browser (new tab on web).
Future<void> launchExternalUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
