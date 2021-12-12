part of 'tv_season_bloc.dart';

abstract class TvSeasonState extends Equatable {
  const TvSeasonState();

  @override
  List<Object> get props => [];
}

class TvSeasonEmpty extends TvSeasonState {
  @override
  List<Object> get props => [];
}

class TvSeasonLoading extends TvSeasonState {
  @override
  List<Object> get props => [];
}

class TvSeasonError extends TvSeasonState {
  final String message;

  TvSeasonError(this.message);

  @override
  List<Object> get props => [];
}

class TvSeasonHasData extends TvSeasonState {
  final Season result;

  TvSeasonHasData(this.result);

  @override
  List<Object> get props => [];
}
