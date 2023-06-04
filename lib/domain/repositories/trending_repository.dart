import 'package:rockers_app/domain/domain.dart';

abstract class TrendingRepository {
  Future<List<Trending>> initialLoad();

  Future<List<Trending>> nextLoad();
}
