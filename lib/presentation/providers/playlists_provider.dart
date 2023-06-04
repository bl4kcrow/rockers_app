import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

final playlistsProvider =
    StateNotifierProvider<PlaylistsNotifier, List<Playlist>>((ref) {
  return PlaylistsNotifier(ref);
});

class PlaylistsNotifier extends StateNotifier<List<Playlist>> {
  PlaylistsNotifier(this.ref) : super([]);

  final Ref ref;

  Future<void> initialLoad() async {
    final List<Playlist> initialPlaylists =
        await ref.watch(playlistRepositoryProvider).initialLoad();

    state = [...initialPlaylists];
  }

  Future<void> nextLoad() async {
    final List<Playlist> nextPlaylists =
        await ref.watch(playlistRepositoryProvider).nextLoad();

    state = [...state, ...nextPlaylists];
  }
}
