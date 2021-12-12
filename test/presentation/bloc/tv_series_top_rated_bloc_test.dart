import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../provider/tv_list_notifier_test.mocks.dart';

void main() {
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTv);
  });

  final tTvModel = Tv(
    firstAirDate: "2021-11-24",
    name: "Hawkeye",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Hawkeye",
    backdropPath: "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
    genreIds: [10759, 18],
    id: 88329,
    overview:
        "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
    popularity: 5530.564,
    posterPath: "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
    voteAverage: 8.6,
    voteCount: 616,
  );

  final tTvList = <Tv>[tTvModel];

  test('initial state should be empry', () {
    expect(tvSeriesTopRatedBloc.state, TvSeriesTopRatedEmpty());
  });

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(GetTvSeriesTopRatedEvent()),
    expect: () => [
      TvSeriesTopRatedLoading(),
      TvSeriesTopRatedHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(GetTvSeriesTopRatedEvent()),
    expect: () => [
      TvSeriesTopRatedLoading(),
      TvSeriesTopRatedError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}
