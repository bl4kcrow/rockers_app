import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rockers_app/data/data.dart';
import 'package:rockers_app/domain/domain.dart';

final trendingRepositoryProvider = Provider<TrendingRepository>((ref) {
  return TrendingRepositoryImpl(FirestoreTrendingDatasource());
});
