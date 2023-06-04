import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockers_app/domain/domain.dart';

final currentPlaylistProvider = StateProvider<Playlist>((ref) {
  return Playlist(
    name: '',
    priority: 1,
    rankingEnable: false,
    songs: [],
  );
});
