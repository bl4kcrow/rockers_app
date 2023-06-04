import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';

class TrendingMapper {
  static Trending firestoreTrendingToEntity(
    FirestoreTrendingModel firestoreTrending,
  ) =>
      Trending(
        id: firestoreTrending.id!,
        priority: firestoreTrending.priority,
        band: firestoreTrending.band,
        title: firestoreTrending.title,
        songId: firestoreTrending.songId,
        trendType: firestoreTrending.trendType,
        videoUrl: firestoreTrending.videoUrl,
      );
}
