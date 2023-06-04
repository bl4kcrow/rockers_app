import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rockers_app/data/data.dart';

class FirestorePlaylistModel {
  FirestorePlaylistModel({
    this.id,
    required this.name,
    required this.priority,
    required this.rankingEnabled,
    required this.songReferences,
    required this.creationDate,
    required this.lastUpdate,
  });

  final String? id;
  final String name;
  final int priority;
  final bool rankingEnabled;
  final List<FirestoreSongReferenceModel> songReferences;
  final DateTime creationDate;
  final DateTime lastUpdate;

  factory FirestorePlaylistModel.fromJson(String str) =>
      FirestorePlaylistModel.fromMap(json.decode(str));

  factory FirestorePlaylistModel.fromMap(Map<String, dynamic> json) =>
      FirestorePlaylistModel(
        id: json['id'],
        name: json['name'],
        priority: json['priority'],
        rankingEnabled: json['rankingEnabled'],
        songReferences: List<FirestoreSongReferenceModel>.from(
          json['songs'].map(
            (x) => FirestoreSongReferenceModel.fromMap(x),
          ),
        ),
        creationDate: json['creationDate'].toDate().toLocal(),
        lastUpdate: json['lastUpdate'].toDate().toLocal(),
      );

  factory FirestorePlaylistModel.fromSnapshot(DocumentSnapshot snapshot) =>
      FirestorePlaylistModel(
        id: snapshot.reference.id,
        name: snapshot.get('name'),
        priority: snapshot.get('priority'),
        rankingEnabled: snapshot.get('rankingEnabled'),
        songReferences: List<FirestoreSongReferenceModel>.from(
          snapshot.get('songs').map(
                (item) => FirestoreSongReferenceModel.fromMap(item),
              ),
        ),
        creationDate: snapshot.get('creationDate').toDate().toLocal(),
        lastUpdate: snapshot.get('lastUpdate').toDate().toLocal(),
      );

  FirestorePlaylistModel copyWith({
    String? id,
    String? name,
    int? priority,
    bool? rankingEnabled,
    List<FirestoreSongReferenceModel>? songReferences,
    DateTime? creationDate,
    DateTime? lastUpdate,
  }) =>
      FirestorePlaylistModel(
        id: id ?? this.id,
        name: name ?? this.name,
        priority: priority ?? this.priority,
        rankingEnabled: rankingEnabled ?? this.rankingEnabled,
        songReferences: songReferences ?? this.songReferences,
        creationDate: creationDate ?? this.creationDate,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'name': name,
        'priority': priority,
        'rankingEnabled': rankingEnabled,
        'songs': List<dynamic>.from(
          songReferences.map(
            (item) => item.toMap(),
          ),
        ),
        'creationDate': Timestamp.fromDate(creationDate),
        'lastUpdate': Timestamp.fromDate(lastUpdate),
      };
}
