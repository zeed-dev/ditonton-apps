part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  const WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> result;

  const WatchlistTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvIsAddedToWatchList extends WatchlistTvState {
  final bool isAdded;

  const TvIsAddedToWatchList(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistTvMessage extends WatchlistTvState {
  final String message;

  const WatchlistTvMessage(this.message);

  @override
  List<Object> get props => [message];
}
