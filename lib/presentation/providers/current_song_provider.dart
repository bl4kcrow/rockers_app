import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

final currentSongProvider =
    NotifierProvider<CurrentSongNotifier, Song>(CurrentSongNotifier.new);

class CurrentSongNotifier extends Notifier<Song> {
  @override
  build() {
    return Song(
      id: '',
      band: '',
      title: '',
      videoUrl: '',
    );
  }

  void update(Song newCurrentsong) async {
    state = newCurrentsong;
  }

  int currentIndex() {
    int currentSongIndex = 0;

    final currentPlaylist = ref.read(currentPlaylistProvider);

    currentSongIndex = currentPlaylist.songs.indexWhere(
      (song) => song.id == state.id,
    );
    return currentSongIndex;
  }
}
