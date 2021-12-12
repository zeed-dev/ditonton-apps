import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/usecases/get_tv_season.dart';
import 'package:ditonton/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_series_season_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeason])
void main() {
  late TvSeasonBloc tvSeasonBloc;
  late MockGetTvSeason mockGetTvSeason;

  setUp(() {
    mockGetTvSeason = MockGetTvSeason();
    tvSeasonBloc = TvSeasonBloc(mockGetTvSeason);
  });

  final tSeason = Season(
      id: "id",
      airDate: DateTime.now(),
      episodes: [
        Episode(
          episodeNumber: 1,
          crew: ["crew"],
          guestStars: ["guestStars"],
          id: 1,
          name: "name",
          overview: "overview",
          productionCode: "productionCode",
          seasonNumber: 1,
          stillPath: "stillPath",
          voteAverage: 2,
          voteCount: 2,
        ),
        Episode(
          episodeNumber: 1,
          crew: ["crew"],
          guestStars: ["guestStars"],
          id: 1,
          name: "name",
          overview: "overview",
          productionCode: "productionCode",
          seasonNumber: 1,
          stillPath: "stillPath",
          voteAverage: 2,
          voteCount: 2,
        ),
      ],
      name: "name",
      overview: "overview",
      seasonResponseId: 1,
      posterPath: "posterPath",
      seasonNumber: 1);

  test('initial state should be empry', () {
    expect(tvSeasonBloc.state, TvSeasonEmpty());
  });

  blocTest<TvSeasonBloc, TvSeasonState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeason.execute(1)).thenAnswer(
        (_) async => Right(tSeason),
      );
      return tvSeasonBloc;
    },
    act: (bloc) => bloc.add(GetTvSeasonEvent(1)),
    expect: () => [
      TvSeasonLoading(),
      TvSeasonHasData(tSeason),
    ],
    verify: (bloc) {
      verify(mockGetTvSeason.execute(1));
    },
  );

  blocTest<TvSeasonBloc, TvSeasonState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTvSeason.execute(1)).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );
      return tvSeasonBloc;
    },
    act: (bloc) => bloc.add(GetTvSeasonEvent(1)),
    expect: () => [
      TvSeasonLoading(),
      TvSeasonError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetTvSeason.execute(1));
    },
  );
}
