import 'package:rockers_app/domain/domain.dart';

abstract class PlaylistRepository {
  Future<List<Playlist>> initialLoad();

  Future<List<Playlist>> nextLoad();
}
