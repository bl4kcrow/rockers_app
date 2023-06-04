import 'package:rockers_app/domain/domain.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  PlaylistRepositoryImpl(this.playlistDatasource);

  final PlaylistDatasource playlistDatasource;

  @override
  Future<List<Playlist>> initialLoad() {
    return playlistDatasource.initialLoad();
  }

  @override
  Future<List<Playlist>> nextLoad() {
    return playlistDatasource.nextLoad();
  }
}
