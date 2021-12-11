part of 'toprated_movie_bloc.dart';

abstract class TopratedMovieState extends Equatable {
  const TopratedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieEmpty extends TopratedMovieState {}

class TopRatedMovieLoading extends TopratedMovieState {}

class TopRatedMovieError extends TopratedMovieState {
  final String message;

  TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMovieHasData extends TopratedMovieState {
  final List<Movie> topRatedMovie;

  TopRatedMovieHasData(
    this.topRatedMovie,
  );

  @override
  List<Object> get props => [topRatedMovie];
}
