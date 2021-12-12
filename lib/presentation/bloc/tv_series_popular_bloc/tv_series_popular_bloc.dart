import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  GetPopularTv getPopularTv;
  TvSeriesPopularBloc(this.getPopularTv) : super(TvSeriesPopularEmpty()) {
    on<GetTvSeriesPopularEvent>((event, emit) async {
      emit(TvSeriesPopularLoading());
      final result = await getPopularTv.execute();
      result.fold(
        (failure) {
          emit(TvSeriesPopularError(failure.message));
        },
        (tvData) {
          emit(TvSeriesPopularHashData(tvData));
        },
      );
    });
  }
}
