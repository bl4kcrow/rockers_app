import 'package:rockers_app/config/config.dart';

class Trending {
  Trending({
    required this.id,
    required this.priority,
    required this.band,
    required this.title,
    required this.songId,
    required this.trendType,
    required this.videoUrl,
  });

  final String id;
  final int priority;
  final String band;
  final String title;
  final String songId;
  final TrendType trendType;
  final String videoUrl;
}
