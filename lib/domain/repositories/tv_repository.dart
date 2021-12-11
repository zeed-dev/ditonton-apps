import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, Season>> getTvSeason(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail tv);
  Future<bool> isAddedTvToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}
