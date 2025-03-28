import 'package:rockers_app/config/config.dart';

class AppVersioning {
  AppVersioning({
    required this.buildNumber,
    required this.currentVersion,
    required this.remoteMinimumVersion,
    required this.remoteRecommendedVersion,
    required this.updateStatus,
  });

  final String buildNumber;
  final String currentVersion;
  final String remoteMinimumVersion;
  final String remoteRecommendedVersion;
  final AppUpdateStatus updateStatus;
}
