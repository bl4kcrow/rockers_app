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
  @override
  void initState() {
    super.initState();

    ref.read(playlistsProvider.notifier).initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final List<Playlist> playlists = ref.watch(playlistsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.playlistsLabel),
      ),
      body: ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return Card(
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
          );
        },
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
