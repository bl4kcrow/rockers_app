import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:rockers_app/presentation/presentation.dart';

final videoPlayerProvider = Provider<VideoPlayerNotifier>((ref) {
  return VideoPlayerNotifier(ref);
});

class VideoPlayerNotifier {
  VideoPlayerNotifier(this.ref);

  final Ref ref;

  final YoutubePlayerController _playerController = YoutubePlayerController(
    params: const YoutubePlayerParams(
      enableCaption: false,
      mute: false,
      showFullscreenButton: true,
      strictRelatedVideos: true,
      showVideoAnnotations: false,
    ),
  );

  YoutubePlayerController get playerController => _playerController;

  Future<void> cueVideoById(String videoId) async {
    await _playerController.cueVideoById(videoId: videoId);
  }

  void fullScreen() {
    _playerController.toggleFullScreen();
  }

  Future<void> loadVideoById(String videoId) async {
    await _playerController.loadVideoById(videoId: videoId);
  }

  Future<void> play() async {
    await _playerController.playVideo();
  }

  Future<void> pause() async {
    await _playerController.pauseVideo();
  }

  Future<void> next() async {
    final currentPlaylist = ref.read(currentPlaylistProvider);
    final currentSongIndex = ref
        .read(
          currentSongProvider.notifier,
        )
        .currentIndex();

    if (currentSongIndex + 1 < currentPlaylist.songs.length) {
      final nextSong = currentPlaylist.songs.elementAt(currentSongIndex + 1);

      await loadVideoById(nextSong.videoId);
      ref.read(currentSongProvider.notifier).update(nextSong);
      ref
          .read(videoMetaDataProvider.notifier)
          .fetchVideoMetaData(nextSong.videoId);
    }
  }

  Future<void> previous() async {
    final currentPlaylist = ref.read(currentPlaylistProvider);
    final currentSongIndex = ref
        .read(
          currentSongProvider.notifier,
        )
        .currentIndex();

    if (currentSongIndex - 1 > 0) {
      final previousSong =
          currentPlaylist.songs.elementAt(currentSongIndex - 1);

      await loadVideoById(previousSong.videoId);
      ref.read(currentSongProvider.notifier).update(previousSong);
      ref
          .read(videoMetaDataProvider.notifier)
          .fetchVideoMetaData(previousSong.videoId);
    }
  }

  Future<void> dispose() async {
    await _playerController.close();
  }
}
