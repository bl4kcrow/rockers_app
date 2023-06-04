import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

final trendingProvider =
    StateNotifierProvider<TrendingNotifier, List<Trending>>((ref) {
  return TrendingNotifier(ref);
});

class TrendingNotifier extends StateNotifier<List<Trending>> {
  TrendingNotifier(
    this.ref,
  ) : super([]);

  final Ref ref;

  Future<void> initialLoad() async {
    final List<Trending> initialTrending =
        await ref.watch(trendingRepositoryProvider).initialLoad();

    state = [...initialTrending];
    setAsCurrentPlaylist();
  }

  Future<void> nextLoad() async {
    final List<Trending> nextTrending =
        await ref.watch(trendingRepositoryProvider).nextLoad();

    state = [...state, ...nextTrending];
    setAsCurrentPlaylist();
  }

  void setAsCurrentPlaylist() {
    ref.read(currentPlaylistProvider.notifier).state = Playlist(
      name: 'Trending Playlist',
      priority: 1,
      rankingEnable: false,
      songs: state
          .map((trending) => Song(
                id: trending.songId,
                band: trending.band,
                title: trending.title,
                trendType: trending.trendType.description,
                videoUrl: trending.videoUrl,
              ))
          .toList(),
    );
  }
}
