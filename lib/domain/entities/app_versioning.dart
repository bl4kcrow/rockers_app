import 'package:rockers_app/config/config.dart';

class AppVersioning {
  AppVersioning({
    required this.updateStatus,
    required this.currentVersion,
    required this.remoteMinimumVersion,
    required this.remoteRecommendedVersion,
  });
  
  final AppUpdateStatus updateStatus;
  final String currentVersion;
  final String remoteMinimumVersion;
  final String remoteRecommendedVersion;
}
