import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  GetWatchlistMovies getWatchlistMovies;
  GetWatchListStatus getWatchListStatus;
  SaveWatchlist saveWatchlist;
  RemoveWatchlist removeWatchlist;

  WatchlistMovieBloc({
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistMovieEmpty()) {
    on<GetWatchlistMovieEvents>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (moviesData) {
          emit(WatchlistMovieHasData(moviesData));
        },
      );
    });

    on<GetWatchlistStatusEvents>((event, emit) async {
      final id = event.id;

      final result = await getWatchListStatus.execute(id);

      emit(MovieIsAddedToWatchList(result));
    });

    on<AddMovieToWatchlistEvents>((event, emit) async {
      final movie = event.movieDetail;

      final result = await saveWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (data) {
        emit(WatchlistMovieMessage(data));
      });
    });

    on<RemoveMovieToWatchlistEvents>((event, emit) async {
      final movie = event.movieDetail;

      final result = await removeWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (data) {
        emit(WatchlistMovieMessage(data));
      });
    });
  }
}
