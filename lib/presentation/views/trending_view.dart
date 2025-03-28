import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

class TrendingView extends ConsumerStatefulWidget {
  const TrendingView({super.key});

  @override
  ConsumerState<TrendingView> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends ConsumerState<TrendingView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_scrollListener);
    _initialize();
  }

  void _initialize() async {
    await ref.read(trendingProvider.notifier).initialLoad();
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      await ref.read(trendingProvider.notifier).nextLoad();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Trending> trending = ref.watch(trendingProvider);
    final isDarkMode = ref.watch(appThemeProvider).isDarkMode;
    AsyncValue<AppVersioning> appVersioning = ref.watch(appVersioningProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.rockers),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              semanticLabel: SemanticLabels.darkModeButton,
            ),
            iconSize: IconSize.extraLarge,
            padding: const EdgeInsets.all(Insets.medium),
            onPressed: () {
              ref.read(appThemeProvider.notifier).toggleDarkMode();
            },
          ),
        ],
        bottom: appVersioning.when(
          data: (appVersioning) {
            if (appVersioning.updateStatus == AppUpdateStatus.optional) {
              return PreferredSize(
                preferredSize: Size.fromHeight(56.0),
                child: OptionalAppUpdateCard(),
              );
            } else {
              return null;
            }
          },
          error: (error, stack) {
            return null;
          },
          loading: () {
            return null;
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
        child: RefreshIndicator(
          displacement: AppConstants.refreshDisplacement,
          onRefresh: () async {
            await ref.read(trendingProvider.notifier).initialLoad();
          },
          child: ListView.builder(
            controller: scrollController,
            itemCount: trending.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              final trendingSong = trending[index];

              return VideoCard(
                song: SongMapper.trendingSongToEntity(trendingSong),
              );
            },
          ),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }
}
