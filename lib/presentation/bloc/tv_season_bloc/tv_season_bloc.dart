import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/usecases/get_tv_season.dart';
import 'package:equatable/equatable.dart';

part 'tv_season_event.dart';
part 'tv_season_state.dart';

class TvSeasonBloc extends Bloc<TvSeasonEvent, TvSeasonState> {
  GetTvSeason getTvSeason;
  TvSeasonBloc(this.getTvSeason) : super(TvSeasonEmpty()) {
    on<GetTvSeasonEvent>((event, emit) async {
      final id = event.id;
      emit(TvSeasonLoading());
      final result = await getTvSeason.execute(id);
      result.fold(
        (failure) {
          emit(TvSeasonError(failure.message));
        },
        (seasonData) {
          emit(TvSeasonHasData(seasonData));
        },
      );
    });
  }
}
