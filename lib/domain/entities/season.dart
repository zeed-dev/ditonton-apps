import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonResponseId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final DateTime airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int seasonResponseId;
  final String posterPath;
  final int seasonNumber;

  @override
  List<Object> get props {
    return [
      id,
      airDate,
      episodes,
      name,
      overview,
      seasonResponseId,
      posterPath,
      seasonNumber,
    ];
  }
}
