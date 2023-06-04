import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';

final playlistRepositoryProvider = Provider<PlaylistRepository>((ref) {
  return PlaylistRepositoryImpl(FirestorePlaylistDatasource());
});
