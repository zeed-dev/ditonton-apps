import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'toprated_movie_event.dart';
part 'toprated_movie_state.dart';

class TopratedMovieBloc extends Bloc<TopratedMovieEvent, TopratedMovieState> {
  GetTopRatedMovies getTopRatedMovies;

  TopratedMovieBloc(this.getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<GetTopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(TopRatedMovieError(failure.message));
        },
        (moviesData) {
          emit(TopRatedMovieHasData(moviesData));
        },
      );
    });
  }
}
