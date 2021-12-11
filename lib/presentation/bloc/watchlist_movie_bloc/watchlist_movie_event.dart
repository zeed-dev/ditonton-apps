part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistMovieEvents extends WatchlistMovieEvent {}

class GetWatchlistStatusEvents extends WatchlistMovieEvent {
  final int id;

  GetWatchlistStatusEvents(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieToWatchlistEvents extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  AddMovieToWatchlistEvents(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieToWatchlistEvents extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  RemoveMovieToWatchlistEvents(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
