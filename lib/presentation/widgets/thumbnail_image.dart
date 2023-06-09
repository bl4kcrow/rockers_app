import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:rockers_app/config/config.dart';

class ThumbnailImage extends StatelessWidget {
  const ThumbnailImage({
    super.key,
    required this.videoId,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
  });

  final String videoId;
  final BoxFit fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final String videoThumbnail = YoutubePlayerController.getThumbnail(
      videoId: videoId,
    );

    return Image.network(
      videoThumbnail,
      fit: fit,
      height: height,
      width: width,
      errorBuilder: (_, __, ___) {
        return Image.network(
          YoutubePlayerController.getThumbnail(
            quality: ThumbnailQuality.high,
            videoId: videoId,
          ),
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (_, __, ___) {
            return Image.asset(
              AppConstants.noImagePath,
              fit: fit,
              height: height,
              width: width,
            );
          },
        );
      },
    );
  }
}
