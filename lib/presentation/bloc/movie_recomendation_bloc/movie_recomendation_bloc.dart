import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recomendation_event.dart';
part 'movie_recomendation_state.dart';

class MovieRecomendationBloc
    extends Bloc<MovieRecomendationEvent, MovieRecomendationState> {
  final GetMovieRecommendations getMovieRecommendations;
  MovieRecomendationBloc(
    this.getMovieRecommendations,
  ) : super(MovieRecomendationEmpty()) {
    on<GetMovieRecomendationEvent>((event, emit) async {
      final id = event.id;

      emit(MovieRecomendationLoading());
      final result = await getMovieRecommendations.execute(id);

      result.fold((failure) {
        emit(MovieRecomendationError(failure.message));
      }, (movie) {
        emit(MovieRecomendationHasData(movie));
      });
    });
  }
}
