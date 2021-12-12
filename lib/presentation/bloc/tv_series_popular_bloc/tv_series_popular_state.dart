part of 'tv_series_popular_bloc.dart';

abstract class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();

  @override
  List<Object> get props => [];
}

class TvSeriesPopularEmpty extends TvSeriesPopularState {
  @override
  List<Object> get props => [];
}

class TvSeriesPopularLoading extends TvSeriesPopularState {
  @override
  List<Object> get props => [];
}

class TvSeriesPopularError extends TvSeriesPopularState {
  final String message;

  TvSeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesPopularHashData extends TvSeriesPopularState {
  final List<Tv> result;

  TvSeriesPopularHashData(this.result);

  @override
  List<Object> get props => [result];
}
