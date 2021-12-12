import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;
  final GetTvWatchListStatus getTvWatchListStatus;
  final GetWatchlistTv getWatchlistTv;

  WatchlistTvBloc({
    required this.getTvWatchListStatus,
    required this.removeTvWatchlist,
    required this.saveTvWatchlist,
    required this.getWatchlistTv,
  }) : super(WatchlistTvEmpty()) {
    on<GetWatchlistTvEvents>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await getWatchlistTv.execute();

      result.fold((failure) {
        emit(WatchlistTvError(failure.message));
      }, (tvData) {
        emit(WatchlistTvHasData(tvData));
      });
    });

    on<GetWatchlistTvStatusEvents>((event, emit) async {
      final id = event.id;

      final result = await getTvWatchListStatus.execute(id);

      emit(TvIsAddedToWatchList(result));
    });

    on<AddTvToWatchListEvents>((event, emit) async {
      final tv = event.tvDetail;

      final result = await saveTvWatchlist.execute(tv);

      result.fold((failure) {
        emit(WatchlistTvError(failure.message));
      }, (r) {
        emit(WatchlistTvMessage(r));
      });
    });

    on<RemoveTvToWatchListEvents>((event, emit) async {
      final tv = event.tvDetail;

      final result = await removeTvWatchlist.execute(tv);

      result.fold((failure) {
        emit(WatchlistTvError(failure.message));
      }, (r) {
        emit(WatchlistTvMessage(r));
      });
    });
  }
}
