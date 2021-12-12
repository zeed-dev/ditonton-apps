import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  SearchTv searchTv;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchTvBloc(this.searchTv) : super(SearchTvEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(SearchTvLoading());
      final result = await searchTv.execute(query);

      result.fold((failure) {
        emit(SearchTvError(failure.message));
      }, (data) {
        emit(SearchTvHasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
