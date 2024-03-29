import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

class TrendingBottomListView extends ConsumerStatefulWidget {
  const TrendingBottomListView({super.key});

  @override
  ConsumerState<TrendingBottomListView> createState() =>
      _TrendingHorizontalListViewState();
}

class _TrendingHorizontalListViewState
    extends ConsumerState<TrendingBottomListView> {
  final ScrollController scrollController = ScrollController();

  bool isNextLoad = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      isNextLoad = await ref.read(trendingProvider.notifier).nextLoad();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final List<Trending> trendingSongs = ref.watch(trendingProvider);
    final currentSong = ref.watch(currentSongProvider);

    if (isNextLoad == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentPlaylist = ref.read(currentPlaylistProvider);
        final currentSongIndex = currentPlaylist.songs.indexWhere(
          (song) => song.id == currentSong.id,
        );

        scrollController.animateTo(
          (currentSongIndex + 1) * (screenSize.width * 0.55 + Insets.medium),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }

    return ListView.separated(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: trendingSongs.length,
      separatorBuilder: (_, __) => const SizedBox(width: Insets.medium),
      itemBuilder: (BuildContext context, int index) {
        final Song song = SongMapper.trendingSongToEntity(
          trendingSongs[index],
        );

        return SizedBox(
          width: screenSize.width * 0.55,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: InkWell(
                  onTap: () {
                    ref.read(videoPlayerProvider).loadVideoById(song.videoId);
                    ref.read(currentSongProvider.notifier).update(song);
                    ref
                        .read(videoMetaDataProvider.notifier)
                        .fetchVideoMetaData(song.videoId);
                  },
                  child: Semantics(
                    label:
                        '${SemanticLabels.songCard} ${song.trendType} ${song.band} ${song.title}',
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
                        song.trendType != null
                            ? Positioned(
                                left: Insets.xsmall,
                                bottom: Insets.xsmall,
                                child: Chip(
                                  label: Text(song.trendType!),
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
