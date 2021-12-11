import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonResponse extends Equatable {
  SeasonResponse({
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
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int seasonResponseId;
  final String? posterPath;
  final int seasonNumber;

  Season toEntity() => Season(
        id: id,
        airDate: airDate,
        episodes: episodes.map((e) => e.toEntitiy()).toList(),
        name: name,
        overview: overview,
        seasonResponseId: seasonResponseId,
        posterPath: posterPath!,
        seasonNumber: seasonNumber,
      );

  factory SeasonResponse.fromJson(Map<String, dynamic> json) => SeasonResponse(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<EpisodeModel>.from(
                (json["episodes"] as List).map((x) => EpisodeModel.fromJson(x)))
            .where((element) => element.stillPath != null)
            .toList(),
        name: json["name"],
        overview: json["overview"],
        seasonResponseId: json["id"],
        posterPath: json["poster_path"] ?? "/abKjah96esLWObidBcWmvKJv61E.jpg",
        seasonNumber: json["season_number"],
      );

  @override
  List<Object?> get props {
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
