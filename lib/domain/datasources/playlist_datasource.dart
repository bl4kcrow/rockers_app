import 'package:rockers_app/domain/domain.dart';

abstract class PlaylistDatasource {
  Future<List<Playlist>> initialLoad();

  Future<List<Playlist>> nextLoad();
}
