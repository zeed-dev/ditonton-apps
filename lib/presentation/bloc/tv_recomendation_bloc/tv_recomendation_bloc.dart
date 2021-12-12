import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendatios.dart';
import 'package:equatable/equatable.dart';

part 'tv_recomendation_event.dart';
part 'tv_recomendation_state.dart';

class TvRecomendationBloc
    extends Bloc<TvRecomendationEvent, TvRecomendationState> {
  GetTvRecommendations getTvRecommendations;
  TvRecomendationBloc(this.getTvRecommendations)
      : super(TvRecomendationEmpty()) {
    on<GetTvRecomendationEvent>((event, emit) async {
      final id = event.id;
      emit(TvRecomendationLoading());
      final result = await getTvRecommendations.execute(id);
      result.fold(
        (failure) {
          emit(TvRecomendationError(failure.message));
        },
        (tvData) {
          emit(TvRecomendationHasData(tvData));
        },
      );
    });
  }
}
