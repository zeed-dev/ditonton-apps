import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/search_tv_bloc/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchTvBloc = SearchTvBloc(mockSearchTv);
  });

  final tTv = Tv(
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

  final tTvList = [tTv];

  final tQuery = "Hawkeye";

  test('initial state should be empry', () {
    expect(searchTvBloc.state, SearchTvEmpty());
  });

  blocTest<SearchTvBloc, SearchTvState>(
    "Should emit [Loading, HasData] when data is gotten successfully",
    build: () {
      when(mockSearchTv.execute(tQuery)).thenAnswer(
        (_) async => Right(tTvList),
      );

      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    "Should emit [Loading, Error] when get search is unsuccessful",
    build: () {
      when(mockSearchTv.execute(tQuery)).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );

      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}
