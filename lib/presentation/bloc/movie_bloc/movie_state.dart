part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieHasData extends MovieState {
  final List<Movie> result;

  MovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
