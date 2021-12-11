import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  final int id;
  final String name;
  final String posterPath;
  final String overview;

  TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  factory TvTable.fromMap(Map<String, dynamic> map) {
    return TvTable(
      id: map['id'],
      name: map['name'],
      posterPath: map['posterPath'],
      overview: map['overview'],
    );
  }

  factory TvTable.fromEntity(TvDetail tvDetail) {
    return TvTable(
      id: tvDetail.id,
      name: tvDetail.name,
      posterPath: tvDetail.posterPath,
      overview: tvDetail.overview,
    );
  }

  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object> get props => [id, name, posterPath, overview];
}
