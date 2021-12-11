part of 'movie_recomendation_bloc.dart';

abstract class MovieRecomendationState extends Equatable {
  const MovieRecomendationState();

  @override
  List<Object> get props => [];
}

class MovieRecomendationEmpty extends MovieRecomendationState {}

class MovieRecomendationLoading extends MovieRecomendationState {}

class MovieRecomendationError extends MovieRecomendationState {
  final String message;

  const MovieRecomendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecomendationHasData extends MovieRecomendationState {
  final List<Movie> result;

  const MovieRecomendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
