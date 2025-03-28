import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';

final remoteConfigProvider = Provider<RemoteConfigRepository>((ref) {
  return RemoteConfigRepositoryImpl(FirebaseRemoteConfigDatasource());
});