import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late final StreamSubscription<YoutubePlayerValue> playerControllerListener;
  late final VideoPlayerNotifier playerProvider;

  @override
  void initState() {
    super.initState();
    playerProvider = ref.read(videoPlayerProvider);

    playerControllerListener = ref
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

    playerProvider.playerController.setFullScreenListener((isFullscreen) {
      if (isFullscreen == false) {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
      }
    });
  }

  @override
  void dispose() {
    playerControllerListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final autoPlay = ref.watch(autoplayProvider);

    if (autoPlay == false) {
      playerControllerListener.pause();
    } else if (playerControllerListener.isPaused) {
      playerControllerListener.resume();
    }

    return PopScope(
      onPopInvokedWithResult: (
        didPop,
        result,
      ) {
        ref.invalidate(videoPlayerProvider);
      },
      child: SafeArea(
        child: YoutubePlayerScaffold(
          autoFullScreen: true,
          controller: playerProvider.playerController,
          defaultOrientations: const [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
          builder: (context, videoPlayer) {
            return Scaffold(
              body: _PlayerScaffoldBody(
                bottomWidget: widget.bottomWidget,
                player: videoPlayer,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AutoPlay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          AppConstants.autoplayLabel,
          style: textTheme.titleMedium,
        ),
        Semantics(
          label: SemanticLabels.autoplaySwitch,
          child: Switch.adaptive(
            value: ref.watch(autoplayProvider),
            onChanged: (value) {
              ref.read(autoplayProvider.notifier).state = value;
              ref
                  .read(sharedUtilityProvider)
                  .setAutoplayEnabled(isAutoplayEnabled: value);
            },
          ),
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
              _Controls(),
              const SizedBox(height: Insets.medium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.small),
                child: VideoTitle(
                  band: currentSong.band,
                  title: currentSong.title,
                ),
              ),
              const SizedBox(height: Insets.medium),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Insets.medium),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _VideoData(
                          currentSong: currentSong,
                          isRankingEnabled: isRankingEnabled,
                        ),
                        const SizedBox(height: Insets.medium),
                        _PlaylistTitle(),
                        SizedBox(
                          height: screenSize.width * 0.6,
                          child: bottomWidget,
                        ),
                      ],
                    ),
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

class _VideoData extends StatelessWidget {
  const _VideoData({
    required this.currentSong,
    required this.isRankingEnabled,
  });

  final Song currentSong;
  final bool isRankingEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const VideoMetaDataInfo(),
        const SizedBox(width: Insets.medium),
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
              subject: '${currentSong.band} - ${currentSong.title}',
            );
          },
          icon: const Icon(
            Icons.share_outlined,
            semanticLabel: SemanticLabels.shareSong,
          ),
        ),
      ],
    );
  }
}

class _Controls extends ConsumerWidget {
  const _Controls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.small,
          vertical: Insets.xsmall,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _AutoPlay(),
            IconButton(
              onPressed: () {
                ref.read(videoPlayerProvider).fullScreen();
              },
              icon: const Icon(
                Icons.fullscreen_outlined,
                color: AppColors.white,
                size: IconSize.extraLarge * 1.2,
                semanticLabel: SemanticLabels.previousSong,
              ),
            ),
            const VideoControls(),
          ],
        ),
      ),
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
      semanticsLabel: '${SemanticLabels.playlist} ${currentPlaylist.name}',
      style: textTheme.titleMedium,
      textAlign: TextAlign.center,
      textScaler: const TextScaler.linear(AppConstants.textScaleFactor),
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
      semanticsLabel: '${SemanticLabels.position} $position',
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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      type,
      semanticsLabel: '${SemanticLabels.trendingType} $type',
      style: textTheme.titleMedium,
    );
  }
}
