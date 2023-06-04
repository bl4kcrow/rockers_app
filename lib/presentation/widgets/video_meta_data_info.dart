import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:rockers_app/config/config.dart';
import 'package:rockers_app/domain/domain.dart';
import 'package:rockers_app/presentation/presentation.dart';

class VideoMetaDataInfo extends ConsumerWidget {
  const VideoMetaDataInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    AsyncValue<VideoMetaData> videoMetaData = ref.watch(videoMetaDataProvider);

    return Column(
      children: [
        Text(
          AppConstants.infoLabel,
          textAlign: TextAlign.center,
          style: textTheme.titleLarge,
        ),
        videoMetaData.when(
          skipLoadingOnRefresh: false,
          data: (metaData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text(
                      AppConstants.viewsLabel,
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      NumberFormat.compact().format(metaData.views),
                      textAlign: TextAlign.center,
                      style: textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(width: Insets.medium),
                Column(
                  children: [
                    Text(
                      AppConstants.durationLabel,
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      metaData.duration.toMinutesSeconds(),
                      textAlign: TextAlign.center,
                      style: textTheme.titleSmall,
                    )
                  ],
                ),
              ],
            );
          },
          error: (_, __) => const SizedBox.shrink(),
          loading: () => const CircularProgressIndicator.adaptive(),
        ),
      ],
    );
  }
}
