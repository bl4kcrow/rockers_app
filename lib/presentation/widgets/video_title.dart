import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/presentation/providers/video_meta_data_provider.dart';
import 'package:rockers_app/domain/entities/video_meta_data.dart';

class VideoTitle extends ConsumerWidget {
  const VideoTitle({
    super.key,
    required this.band,
    required this.title,
  });

  final String band;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    AsyncValue<VideoMetaData> videoMetaData = ref.watch(videoMetaDataProvider);

    return ExpansionTile(
      title: Text(
        band,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleMedium,
        textScaler: const TextScaler.linear(AppConstants.textScaleFactor),
        semanticsLabel: band,
      ),
      subtitle: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        semanticsLabel: title,
        style: textTheme.titleSmall,
      ),
      children: [
        SizedBox(
          height: 150.0,
          child: ListView(
            children: [
              Text(
                videoMetaData.when(
                  skipLoadingOnRefresh: false,
                  data: (metaData) => metaData.description,
                  loading: () => AppConstants.loading,
                  error: (error, stackTrace) => AppConstants.noDescription,
                ),
                style: textTheme.bodySmall,
              ),
            
            ],
          ),
        ),
      ],
    );
  }
}
