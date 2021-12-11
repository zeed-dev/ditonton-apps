import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvSeason {
  final TvRepository repository;

  GetTvSeason(this.repository);

  Future<Either<Failure, Season>> execute(int id) {
    return repository.getTvSeason(id);
  }
}
