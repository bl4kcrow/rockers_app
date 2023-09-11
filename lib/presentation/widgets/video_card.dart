import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

class VideoCard extends ConsumerWidget {
  const VideoCard({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;


    return Semantics(
      label: '${SemanticLabels.songCard} ${song.band} ${song.title}',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Insets.small),
        child: InkWell(
          onTap: () {
            ref.read(currentSongProvider.notifier).update(song);
            ref.read(trendingProvider.notifier).setAsCurrentPlaylist();
            ref.read(videoPlayerProvider).loadVideoById(song.videoId);
            ref
                .read(videoMetaDataProvider.notifier)
                .fetchVideoMetaData(song.videoId);

            context.goNamed(
              Routes.videoPlaybackScreen,
              pathParameters: {'page': '0'},
              extra: {
                'bottomWidget': const TrendingBottomListView(),
              },
            );
          },
          child: Column(
            children: [
              SizedBox(
                height: screenSize.width * 0.5,
                width: screenSize.width,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppConstants.mediumRadius,
                      ),
                      child: ThumbnailImage(
                        videoId: song.videoId,
                        height: screenSize.width * 0.5,
                        width: screenSize.width,
                      ),
                    ),
                    (song.trendType != null)
                        ? Positioned(
                            right: Insets.small,
                            top: Insets.small,
                            child: Chip(
                              label: Text(song.trendType!),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const SizedBox(height: Insets.medium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.xsmall),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.band,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleLarge,
                            textScaleFactor: AppConstants.textScaleFactor,
                          ),
                          Text(
                            song.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(
                          song.videoUrl,
                          subject: '${song.band} - ${song.title}',
                        );
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        semanticLabel:
                            '${SemanticLabels.shareSong} ${song.band} ${song.title}',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
