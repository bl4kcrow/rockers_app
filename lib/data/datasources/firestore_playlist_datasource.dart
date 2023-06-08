import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';

class FirestorePlaylistDatasource implements PlaylistDatasource {
  final _playlistCollection =
      FirebaseFirestore.instance.collection('playlists');

  static const int _queryLimit = 10;

  DocumentSnapshot? _lastDocumentSnapshot;

  @override
  Future<List<Playlist>> initialLoad() async {
    final List<Playlist> playLists = [];

    final querySnapshot =
        await _playlistCollection
        .limit(_queryLimit)
        .where(
          'isActive',
          isEqualTo: true,
        )
        .orderBy('priority')
        .get();

    playLists.addAll(
      querySnapshot.docs
          .map(
            (documentSnapshot) => PlaylistMapper.firestoreToEntity(
              FirestorePlaylistModel.fromSnapshot(documentSnapshot),
            ),
          )
          .toList(),
    );

    _lastDocumentSnapshot = (querySnapshot.docs.isNotEmpty == true)
        ? querySnapshot.docs.last
        : null;

    return playLists;
  }

  @override
  Future<List<Playlist>> nextLoad() async {
    final List<Playlist> nextPlaylists = [];

    if (_lastDocumentSnapshot != null) {
      final querySnapshot = await _playlistCollection
          .limit(_queryLimit)
          .where(
            'isActive',
            isEqualTo: true,
          )
          .orderBy('priority')
          .startAfterDocument(_lastDocumentSnapshot!)
          .get();

      nextPlaylists.addAll(
        querySnapshot.docs
            .map(
              (documentSnapshot) => PlaylistMapper.firestoreToEntity(
                FirestorePlaylistModel.fromSnapshot(documentSnapshot),
              ),
            )
            .toList(),
      );

      _lastDocumentSnapshot = (querySnapshot.docs.isNotEmpty == true)
          ? querySnapshot.docs.last
          : null;
    }

    return nextPlaylists;
  }
}
