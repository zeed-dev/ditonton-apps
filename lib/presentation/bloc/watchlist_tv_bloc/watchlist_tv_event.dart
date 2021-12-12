part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistTvEvents extends WatchlistTvEvent {}

class GetWatchlistTvStatusEvents extends WatchlistTvEvent {
  final int id;

  GetWatchlistTvStatusEvents(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvToWatchListEvents extends WatchlistTvEvent {
  final TvDetail tvDetail;

  AddTvToWatchListEvents(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveTvToWatchListEvents extends WatchlistTvEvent {
  final TvDetail tvDetail;

  RemoveTvToWatchListEvents(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
