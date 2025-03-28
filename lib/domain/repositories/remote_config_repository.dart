abstract class RemoteConfigRepository {
  Future<void> initialize();
  String getMinimumVersionRequired();
  String getRecommendedVersion();
}