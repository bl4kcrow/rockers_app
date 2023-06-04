import 'dart:convert';

class FirestoreSongReferenceModel {
  FirestoreSongReferenceModel({
    required this.songId,
    required this.band,
    required this.title,
    required this.videoUrl,
    this.position,
  });

  final String songId;
  final String band;
  final String title;
  final String videoUrl;
  final int? position;

  FirestoreSongReferenceModel copyWith({
    String? songId,
    String? band,
    String? title,
    String? videoUrl,
    int? position,
  }) =>
      FirestoreSongReferenceModel(
        songId: songId ?? this.songId,
        band: band ?? this.band,
        title: title ?? this.title,
        videoUrl: videoUrl ?? this.videoUrl,
        position: position ?? this.position,
      );

  factory FirestoreSongReferenceModel.fromJson(String str) =>
      FirestoreSongReferenceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FirestoreSongReferenceModel.fromMap(Map<String, dynamic> json) =>
      FirestoreSongReferenceModel(
        songId: json['songId'],
        band: json['band'],
        title: json['title'],
        videoUrl: json['videoUrl'],
        position: json['position'],
      );

  Map<String, dynamic> toMap() => {
        'songId': songId,
        'band': band,
        'title': title,
        'videoUrl': videoUrl,
        'position': position,
      };
}
