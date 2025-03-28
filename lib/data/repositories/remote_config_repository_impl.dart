import 'package:rockers_app/domain/domain.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  RemoteConfigRepositoryImpl(
    this.remoteConfigDatasource,
  );

  final RemoteConfigDatasource remoteConfigDatasource;

  @override
  Future<void> initialize() async {
    return await remoteConfigDatasource.initialize();
  }

  @override
  String getMinimumVersionRequired() {
    return remoteConfigDatasource.getMinimumVersionRequired();
  }

  @override
  String getRecommendedVersion() {
    return remoteConfigDatasource.getRecommendedVersion();
  }
}
