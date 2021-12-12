import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  GetTopRatedTv getTopRatedTv;
  TvSeriesTopRatedBloc(this.getTopRatedTv) : super(TvSeriesTopRatedEmpty()) {
    on<TvSeriesTopRatedEvent>((event, emit) async {
      emit(TvSeriesTopRatedLoading());
      final result = await getTopRatedTv.execute();
      result.fold(
        (failure) {
          emit(TvSeriesTopRatedError(failure.message));
        },
        (tvData) {
          emit(TvSeriesTopRatedHasData(tvData));
        },
      );
    });
  }
}
