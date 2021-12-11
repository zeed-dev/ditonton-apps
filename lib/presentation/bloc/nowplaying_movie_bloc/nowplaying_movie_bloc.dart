import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'nowplaying_movie_event.dart';
part 'nowplaying_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<GetNowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(NowPlayingMovieError(failure.message));
        },
        (moviesData) {
          emit(NowPlayingMovieHasData(moviesData));
        },
      );
    });
  }
}
