import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

class PlaylistsView extends ConsumerStatefulWidget {
  const PlaylistsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlaylistsViewState();
}

class _PlaylistsViewState extends ConsumerState<PlaylistsView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_scrollListener);
    ref.read(playlistsProvider.notifier).initialLoad();
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      await ref.read(playlistsProvider.notifier).nextLoad();
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

    final List<Playlist> playlists = ref.watch(playlistsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.playlistsLabel,
          semanticsLabel: AppConstants.playlistsLabel,
        ),
      ),
      body: RefreshIndicator(
        displacement: AppConstants.refreshDisplacement,
        onRefresh: () async {
          ref.read(playlistsProvider.notifier).initialLoad();
        },
        child: ListView.builder(
          controller: scrollController,
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            return Semantics(
              label: '${SemanticLabels.playlist} ${playlists[index].name}',
              child: Card(
                elevation: 2.0,
                child: Container(
                  height: screenSize.width * 0.6,
                  padding: const EdgeInsets.fromLTRB(
                    Insets.medium,
                    Insets.small,
                    Insets.none,
                    Insets.small,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        playlists[index].name,
                        style: textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: AppConstants.textScaleFactor,
                      ),
                      Expanded(
                        child: PlaylistHorizontalListView(
                          songs: playlists[index].songs,
                          rankingEnabled: playlists[index].rankingEnable,
                          name: playlists[index].name,
                          priority: playlists[index].priority,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
