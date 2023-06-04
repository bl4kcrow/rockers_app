import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Song {
  Song({
    required this.id,
    required this.band,
    required this.title,
    required this.videoUrl,
    this.position,
    this.trendType,
  });

  final String id;
  final String band;
  final String title;
  final String videoUrl;
  final int? position;
  final String? trendType;

  String get videoId => YoutubePlayerController.convertUrlToId(videoUrl) ?? '';
}
