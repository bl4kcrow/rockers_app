import 'package:rockers_app/domain/domain.dart';

class TrendingRepositoryImpl implements TrendingRepository {
  TrendingRepositoryImpl(
    this.trendingDatasource,
  );

  final TrendingDatasource trendingDatasource;

  @override
  Future<List<Trending>> initialLoad() async {
    return await trendingDatasource.initialLoad();
  }

  @override
  Future<List<Trending>> nextLoad() async {
    return await trendingDatasource.nextLoad();
  }
}
