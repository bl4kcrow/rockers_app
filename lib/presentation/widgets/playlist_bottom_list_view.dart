import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

class PlaylistBottomListView extends ConsumerStatefulWidget {
  const PlaylistBottomListView({
    super.key,
    this.rankingEnabled = false,
  });

  final bool rankingEnabled;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlayListBottomListViewState();
}

class _PlayListBottomListViewState
    extends ConsumerState<PlaylistBottomListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final List<Song> songs = ref.watch(currentPlaylistProvider).songs;
    final currentSong = ref.watch(currentSongProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentSongIndex = songs.indexWhere(
        (song) => song.id == currentSong.id,
      );

      scrollController.animateTo(
        (currentSongIndex + 1) * (screenSize.width * 0.55 + Insets.medium),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    return ListView.separated(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: songs.length,
      separatorBuilder: (_, __) => const SizedBox(width: Insets.medium),
      itemBuilder: (BuildContext context, int index) {
        final Song song = songs[index];

        return SizedBox(
          width: screenSize.width * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: InkWell(
                  onTap: () {
                    ref.read(currentSongProvider.notifier).update(song);
                    ref.read(videoPlayerProvider).loadVideoById(song.videoId);
                    ref
                        .read(videoMetaDataProvider.notifier)
                        .fetchVideoMetaData(song.videoId);
                  },
                  child: Semantics(
                    label:
                        '${SemanticLabels.songCard} ${song.band} ${song.title}',
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppConstants.smallRadius,
                            ),
                            child: ThumbnailImage(
                              videoId: song.videoId,
                            ),
                          ),
                        ),
                        widget.rankingEnabled == true
                            ? Positioned(
                                right: Insets.small,
                                top: Insets.small,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.smokyBlack.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.frenchWine,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(Insets.medium),
                                  child: Text(
                                    NumberFormat('00').format(song.position),
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      song.band,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
