import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rockers_app/config/config.dart';

class FirestoreTrendingModel {
  FirestoreTrendingModel({
    this.id,
    required this.band,
    required this.priority,
    required this.songId,
    required this.title,
    this.trendType = TrendType.newRelease,
    required this.videoUrl,
  });

  final String band;
  final String? id;
  final int priority;
  final String songId;
  final String title;
  final TrendType trendType;
  final String videoUrl;

  FirestoreTrendingModel copyWith({
    String? id,
    String? band,
    int? priority,
    String? songId,
    String? title,
    TrendType? trendType,
    String? videoUrl,
  }) =>
      FirestoreTrendingModel(
        id: id ?? this.id,
        band: band ?? this.band,
        priority: priority ?? this.priority,
        songId: songId ?? this.songId,
        title: title ?? this.title,
        trendType: trendType ?? this.trendType,
        videoUrl: videoUrl ?? this.videoUrl,
      );

  factory FirestoreTrendingModel.fromJson(String str) =>
      FirestoreTrendingModel.fromMap(json.decode(str));

  factory FirestoreTrendingModel.fromSnapshot(DocumentSnapshot snapshot) =>
      FirestoreTrendingModel(
        id: snapshot.reference.id,
        band: snapshot.get('band'),
        priority: snapshot.get('priority'),
        songId: snapshot.get('songId'),
        title: snapshot.get('title'),
        trendType: TrendType.fromJson(snapshot.get('trendType')),
        videoUrl: snapshot.get('videoUrl'),
      );

  String toJson() => json.encode(toMap());

  factory FirestoreTrendingModel.fromMap(Map<String, dynamic> json) =>
      FirestoreTrendingModel(
        id: json['id'],
        band: json['band'],
        priority: json['priority'],
        songId: json['songId'],
        title: json['title'],
        trendType: TrendType.fromJson(json['trendType']),
        videoUrl: json['videoUrl'],
      );

  Map<String, dynamic> toMap() => {
        'band': band,
        'priority': priority,
        'songId': songId,
        'title': title,
        'trendType': trendType.name,
        'videoUrl': videoUrl,
      };
}
