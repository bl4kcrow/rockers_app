import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';

class FirestoreTrendingDatasource implements TrendingDatasource {
  final _trendingCollection = FirebaseFirestore.instance.collection('trending');

  static const int _queryLimit = 10;

  DocumentSnapshot? _lastDocumentSnapshot;

  @override
  Future<List<Trending>> initialLoad() async {
    final List<Trending> trendingList = [];

    final querySnapshot =
        await _trendingCollection.limit(_queryLimit).orderBy('priority').get();

    trendingList.addAll(
      querySnapshot.docs
          .map(
            (documentSnapshot) => TrendingMapper.firestoreTrendingToEntity(
              FirestoreTrendingModel.fromSnapshot(documentSnapshot),
            ),
          )
          .toList(),
    );

    _lastDocumentSnapshot = (querySnapshot.docs.isNotEmpty == true)
        ? querySnapshot.docs.last
        : null;

    return trendingList;
  }

  @override
  Future<List<Trending>> nextLoad() async {
    final List<Trending> nextTrendingList = [];

    if (_lastDocumentSnapshot != null) {
      final querySnapshot = await _trendingCollection
          .limit(_queryLimit)
          .orderBy('priority')
          .startAfterDocument(_lastDocumentSnapshot!)
          .get();

      nextTrendingList.addAll(
        querySnapshot.docs
            .map(
              (documentSnapshot) => TrendingMapper.firestoreTrendingToEntity(
                FirestoreTrendingModel.fromSnapshot(documentSnapshot),
              ),
            )
            .toList(),
      );

      _lastDocumentSnapshot = (querySnapshot.docs.isNotEmpty == true)
          ? querySnapshot.docs.last
          : null;
    }

    return nextTrendingList;
  }
}
