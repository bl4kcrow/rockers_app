import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';

class PlaylistMapper {
  static Playlist firestoreToEntity(
    FirestorePlaylistModel firestorePlaylistModel,
  ) =>
      Playlist(
        name: firestorePlaylistModel.name,
        priority: firestorePlaylistModel.priority,
        rankingEnable: firestorePlaylistModel.rankingEnabled,
        songs: firestorePlaylistModel.songReferences
            .map(
              (firestoreSong) =>
                  SongMapper.firestoreSongReferenceToEntity(firestoreSong),
            )
            .toList(),
      );
}
