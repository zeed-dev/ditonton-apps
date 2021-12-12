import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_now_playing_event.dart';
part 'tv_series_now_playing_state.dart';

class TvSeriesNowPlayingBloc
    extends Bloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> {
  GetNowPlayingTv getNowPlayingTv;

  TvSeriesNowPlayingBloc(this.getNowPlayingTv)
      : super(TvSeriesNowPlayingEmpty()) {
    on<GetTvSeriesNowPlayingEvent>((event, emit) async {
      emit(TvSeriesNowPlayingLoading());
      final result = await getNowPlayingTv.excute();
      result.fold(
        (failure) {
          emit(TvSeriesNowPlayingError(failure.message));
        },
        (tvData) {
          emit(TvSeriesNowPlayingHasData(tvData));
        },
      );
    });
  }
}
