import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/presentation/presentation.dart';

class VideoControls extends ConsumerWidget {
  const VideoControls({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoPlayer = ref.watch(videoPlayerProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.outlined(
          onPressed: () {
            ref.read(videoPlayerProvider).previous();
          },
          icon: const Icon(
            Icons.skip_previous_outlined,
            semanticLabel: SemanticLabels.previousSong,
          ),
        ),
        YoutubeValueBuilder(
          controller: videoPlayer.playerController,
          builder: (context, value) => IconButton.outlined(
            iconSize: IconSize.extraLarge * 2,
            onPressed: () {
              if (value.playerState == PlayerState.paused ||
                  value.playerState == PlayerState.cued) {
                videoPlayer.play();
              } else {
                videoPlayer.pause();
              }
            },
            icon: Icon(
              value.playerState == PlayerState.playing
                  ? Icons.pause_outlined
                  : Icons.play_arrow_outlined,
              semanticLabel: value.playerState == PlayerState.playing
                  ? SemanticLabels.pauseSong
                  : SemanticLabels.playSong,
            ),
          ),
        ),
        IconButton.outlined(
          onPressed: () {
            ref.read(videoPlayerProvider).next();
          },
          icon: const Icon(
            Icons.skip_next_outlined,
            semanticLabel: SemanticLabels.nextSong,
          ),
        ),
      ],
    );
  }
}
