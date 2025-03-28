import 'package:rockers_app/config/config.dart';
import 'package:url_launcher/url_launcher.dart';

void launchAppPlayStore() {
    final url = Uri.parse('market://details?id=${AppConstants.playStoreAppId}');

    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }