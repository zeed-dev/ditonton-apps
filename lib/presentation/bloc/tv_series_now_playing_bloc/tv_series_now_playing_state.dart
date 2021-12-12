part of 'tv_series_now_playing_bloc.dart';

abstract class TvSeriesNowPlayingState extends Equatable {
  const TvSeriesNowPlayingState();

  @override
  List<Object> get props => [];
}

class TvSeriesNowPlayingEmpty extends TvSeriesNowPlayingState {
  @override
  List<Object> get props => [];
}

class TvSeriesNowPlayingLoading extends TvSeriesNowPlayingState {
  @override
  List<Object> get props => [];
}

class TvSeriesNowPlayingError extends TvSeriesNowPlayingState {
  final String message;

  TvSeriesNowPlayingError(this.message);

  @override
  List<Object> get props => [];
}

class TvSeriesNowPlayingHasData extends TvSeriesNowPlayingState {
  final List<Tv> result;

  TvSeriesNowPlayingHasData(this.result);

  @override
  List<Object> get props => [];
}
