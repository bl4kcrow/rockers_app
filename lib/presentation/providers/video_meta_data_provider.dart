import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockers_app/config/config.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:rockers_app/domain/domain.dart';

final videoMetaDataProvider =
    AsyncNotifierProvider<VideoMetaDataNotifier, VideoMetaData>(
        VideoMetaDataNotifier.new);

class VideoMetaDataNotifier extends AsyncNotifier<VideoMetaData> {
  @override
  Future<VideoMetaData> build() {
    return Future.value(
      VideoMetaData(
        views: 0,
        duration: Duration.zero,
        description: AppConstants.noDescription,
      ),
    );
  }

  Future<void> fetchVideoMetaData(String videoId) async {
    final youtubeExplode = YoutubeExplode();
    final videoExplode = await youtubeExplode.videos.get(videoId);
    youtubeExplode.close();

    await update(
      (currentState) => VideoMetaData(
        views: videoExplode.engagement.viewCount,
        duration: videoExplode.duration ?? Duration.zero,
        description: videoExplode.description,
      ),
    );

  }
}
