import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
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
