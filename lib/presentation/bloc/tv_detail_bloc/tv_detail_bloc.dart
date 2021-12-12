import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  GetTvDetail getTvDetail;
  TvDetailBloc(this.getTvDetail) : super(TvDetailEmpty()) {
    on<GetTvDetailEvent>((event, emit) async {
      final id = event.id;

      final result = await getTvDetail.execute(id);

      result.fold((failure) {
        emit(TvDetailError(failure.message));
      }, (movieDetail) {
        emit(TvDetailHasData(movieDetail));
      });
    });
  }
}
