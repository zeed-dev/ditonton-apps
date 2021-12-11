import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int> episodeRunTime;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props {
    return [
      backdropPath,
      episodeRunTime,
      genres,
      homepage,
      id,
      inProduction,
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      status,
      tagline,
      type,
      voteAverage,
      voteCount,
    ];
  }
}
