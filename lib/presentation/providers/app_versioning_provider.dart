import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:rockers_app/config/utils/app_update_status.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

final appVersioningProvider =
    AsyncNotifierProvider<AppVersioningNotifier, AppVersioning>(
        AppVersioningNotifier.new);

class AppVersioningNotifier extends AsyncNotifier<AppVersioning> {
  @override
  Future<AppVersioning> build() async {
    final remoteConfig = ref.watch(remoteConfigProvider);
    await remoteConfig.initialize();

    final remoteMinimumVersion = remoteConfig.getMinimumVersionRequired();
    final remoteRecommendedVersion = remoteConfig.getRecommendedVersion();

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    AppUpdateStatus updateStatus = AppUpdateStatus.noUpdate;

    if (currentVersion.isNotEmpty &&
        remoteMinimumVersion.isNotEmpty &&
        remoteRecommendedVersion.isNotEmpty) {
      final parsedCurrentVersion = Version.parse(currentVersion);
      final parsedMinimumVersion = Version.parse(remoteMinimumVersion);
      final parsedRecommendedVersion = Version.parse(remoteRecommendedVersion);
      
      if (parsedCurrentVersion < parsedMinimumVersion) {
        updateStatus = AppUpdateStatus.mandatory;
      } else if (parsedCurrentVersion < parsedRecommendedVersion) {
        updateStatus = AppUpdateStatus.optional;
      }
    }

    return AppVersioning(
        currentVersion: currentVersion,
        remoteMinimumVersion: remoteMinimumVersion,
        remoteRecommendedVersion: remoteRecommendedVersion,
        updateStatus: updateStatus);
  }
}
