import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

class PlaylistHorizontalListView extends ConsumerWidget {
  const PlaylistHorizontalListView({
    super.key,
    required this.name,
    required this.priority,
    this.rankingEnabled = false,
    required this.songs,
  });

  final String name;
  final int priority;
  final bool rankingEnabled;
  final List<Song> songs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: songs.length,
      separatorBuilder: (_, __) => const SizedBox(width: Insets.medium),
      itemBuilder: (BuildContext context, int index) {
        final Song song = songs[index];

        return SizedBox(
          width: screenSize.width * 0.5,
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
                    ref.read(currentPlaylistProvider.notifier).state = Playlist(
                      name: name,
                      priority: priority,
                      rankingEnable: rankingEnabled,
                      songs: songs,
                    );

                    context.goNamed(
                      Routes.videoPlaybackScreen,
                      pathParameters: {'page': '1'},
                      extra: {
                        'bottomWidget': PlaylistBottomListView(
                          rankingEnabled: rankingEnabled,
                        ),
                      },
                    );
                  },
                  child: Semantics(
                    label: rankingEnabled
                        ? '${SemanticLabels.songCard} ${SemanticLabels.position} ${song.position} ${song.band} ${song.title}'
                        : '${SemanticLabels.songCard} ${song.band} ${song.title}',
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
                        rankingEnabled == true
                            ? Positioned(
                                right: Insets.small,
                                top: Insets.small,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.smokyBlack
                                        .withValues(alpha: 0.7),
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
                      semanticsLabel: song.band,
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      semanticsLabel: song.title,
                      style: textTheme.labelLarge,
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
