import 'package:rockers_app/domain/domain.dart';

class Playlist {
  Playlist({
    required this.name,
    required this.priority,
    required this.rankingEnable,
    required this.songs,
  });

  final String name;
  final int priority;
  final bool rankingEnable;
  final List<Song> songs;
}
