import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final int episodeNumber;
  final List<dynamic> crew;
  final List<dynamic> guestStars;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  Episode toEntitiy() => Episode(
        episodeNumber: episodeNumber,
        crew: crew,
        guestStars: guestStars,
        id: id,
        name: name,
        overview: overview,
        productionCode: productionCode,
        seasonNumber: seasonNumber,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        episodeNumber: json["episode_number"],
        crew: List<dynamic>.from(json["crew"].map((x) => x)),
        guestStars: List<dynamic>.from(json["guest_stars"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "episode_number": episodeNumber,
        "crew": List<dynamic>.from(crew.map((x) => x)),
        "guest_stars": List<dynamic>.from(guestStars.map((x) => x)),
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  List<Object?> get props {
    return [
      episodeNumber,
      crew,
      guestStars,
      id,
      name,
      overview,
      productionCode,
      seasonNumber,
      stillPath,
      voteAverage,
      voteCount,
    ];
  }
}
