import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';

class SongMapper {
  static Song firestoreSongReferenceToEntity(
          FirestoreSongReferenceModel firestoreSong) =>
      Song(
        id: firestoreSong.songId,
        band: firestoreSong.band,
        title: firestoreSong.title,
        videoUrl: firestoreSong.videoUrl,
        position: firestoreSong.position,
      );
  static Song trendingSongToEntity(Trending trendingSong) => Song(
        id: trendingSong.songId,
        band: trendingSong.band,
        title: trendingSong.title,
        trendType: trendingSong.trendType.description,
        videoUrl: trendingSong.videoUrl,
      );
}
