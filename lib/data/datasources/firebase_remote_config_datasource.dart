import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:rockers_app/domain/domain.dart';

class FirebaseRemoteConfigDatasource implements RemoteConfigDatasource {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  Future<void> initialize() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.setDefaults({
      'requiredMinimumVersion': '2.2.0',
      'recommendedMinimumVersion': '2.0.0',
    });

    await remoteConfig.fetchAndActivate();
  }

  @override
  String getMinimumVersionRequired() {
    return remoteConfig.getString('requiredMinimumVersion');
  }

  @override
  String getRecommendedVersion() {
    return remoteConfig.getString('recommendedMinimumVersion');
  }
}
