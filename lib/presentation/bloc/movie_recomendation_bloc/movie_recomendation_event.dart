part of 'movie_recomendation_bloc.dart';

abstract class MovieRecomendationEvent extends Equatable {
  const MovieRecomendationEvent();

  @override
  List<Object> get props => [];
}

class GetMovieRecomendationEvent extends MovieRecomendationEvent {
  final int id;

  GetMovieRecomendationEvent(this.id);

  @override
  List<Object> get props => [];
}
