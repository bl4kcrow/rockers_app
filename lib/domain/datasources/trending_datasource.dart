import 'package:rockers_app/domain/domain.dart';

abstract class TrendingDatasource {
  Future<List<Trending>> initialLoad();

  Future<List<Trending>> nextLoad();
}
