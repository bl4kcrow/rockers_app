import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

class VideoPlaybackScreen extends ConsumerStatefulWidget {
  final Widget bottomWidget;

  const VideoPlaybackScreen({
    super.key,
    required this.bottomWidget,
  });

  @override
  ConsumerState<VideoPlaybackScreen> createState() =>
      _VideoPlaybackScreenState();
}

class _VideoPlaybackScreenState extends ConsumerState<VideoPlaybackScreen> {
  late final StreamSubscription<YoutubePlayerValue> _playerControllerListener;

  @override
  void initState() {
    super.initState();

    _playerControllerListener = ref
        .read(
          videoPlayerProvider,
        )
        .playerController
        .listen(
      (event) {
        if (event.playerState == PlayerState.ended) {
          ref.read(videoPlayerProvider).next();
        }
      },
    );
  }

  @override
  void dispose() {
    _playerControllerListener.cancel();
    ref.invalidate(videoPlayerProvider);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = ref.watch(videoPlayerProvider);

    final autoPlay = ref.watch(autoplayProvider);

    if (autoPlay == false) {
      _playerControllerListener.pause();
    } else if (_playerControllerListener.isPaused) {
      _playerControllerListener.resume();
    }

    return SafeArea(
      child: YoutubePlayerScaffold(
        autoFullScreen: false,
        controller: playerProvider.playerController,
        builder: (context, videoPlayer) {
          return Scaffold(
            body: _PlayerScaffoldBody(
              bottomWidget: widget.bottomWidget,
              player: videoPlayer,
            ),
          );
        },
      ),
    );
  }
}

class _AutoPlay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppConstants.upNextLabel,
          style: textTheme.titleLarge,
        ),
        Row(
          children: [
            Text(
              AppConstants.autoplayLabel,
              style: textTheme.bodyLarge,
            ),
            Switch.adaptive(
              value: ref.watch(autoplayProvider),
              onChanged: (value) {
                ref.read(autoplayProvider.notifier).state = value;
                ref
                    .read(sharedUtilityProvider)
                    .setAutoplayEnabled(isAutoplayEnabled: value);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _PlayerScaffoldBody extends ConsumerWidget {
  final Widget bottomWidget;

  final Widget player;
  const _PlayerScaffoldBody({
    required this.bottomWidget,
    required this.player,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenSize = MediaQuery.of(context).size;
    final Song currentSong = ref.watch(currentSongProvider);
    final bool isRankingEnabled =
        ref.watch(currentPlaylistProvider).rankingEnable;

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VideoPlayer(videoPlayer: player),
              const SizedBox(height: Insets.medium),
              VideoTitle(
                band: currentSong.band,
                title: currentSong.title,
              ),
              const SizedBox(height: Insets.large),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.small),
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: Insets.medium,
                        children: [
                          const VideoMetaDataInfo(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (currentSong.trendType != null) ...[
                                _TrendType(
                                  type: currentSong.trendType!,
                                ),
                              ] else if (currentSong.position != null &&
                                  isRankingEnabled == true) ...[
                                _SongPosition(
                                  position: currentSong.position!,
                                )
                              ],
                              IconButton(
                                onPressed: () {
                                  Share.share(
                                    currentSong.videoUrl,
                                    subject:
                                        '${currentSong.band} - ${currentSong.title}',
                                  );
                                },
                                icon: const Icon(
                                  Icons.share_outlined,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: Insets.large),
                      _PlaylistTitle(),
                      const SizedBox(height: Insets.medium),
                      const VideoControls(),
                      const SizedBox(height: Insets.medium),
                      _AutoPlay(),
                      SizedBox(
                        height: screenSize.width * 0.55,
                        child: bottomWidget,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return VideoPlayer(videoPlayer: player);
        }
      },
    );
  }
}

class _PlaylistTitle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Playlist currentPlaylist = ref.watch(currentPlaylistProvider);

    return Text(
      currentPlaylist.name,
      style: textTheme.titleLarge,
      textAlign: TextAlign.center,
      textScaleFactor: AppConstants.textScaleFactor,
    );
  }
}

class _SongPosition extends StatelessWidget {
  const _SongPosition({
    required this.position,
  });

  final int position;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      NumberFormat('00').format(position),
      style: textTheme.displayLarge?.copyWith(
        color: AppColors.frenchWine,
      ),
    );
  }
}

class _TrendType extends StatelessWidget {
  const _TrendType({
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        type,
      ),
      side: const BorderSide(color: AppColors.frenchWine),
    );
  }
}
