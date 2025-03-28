abstract class RemoteConfigDatasource {
  Future<void> initialize();
  String getMinimumVersionRequired();
  String getRecommendedVersion();
}