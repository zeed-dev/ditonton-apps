part of 'tv_season_bloc.dart';

abstract class TvSeasonEvent extends Equatable {
  const TvSeasonEvent();

  @override
  List<Object> get props => [];
}

class GetTvSeasonEvent extends TvSeasonEvent {
  final int id;

  GetTvSeasonEvent(this.id);

  @override
  List<Object> get props => [id];
}
