import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([
  WatchlistTvBloc,
  GetWatchlistTv,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    watchlistTvBloc = WatchlistTvBloc(
      getWatchlistTv: mockGetWatchlistTv,
      getTvWatchListStatus: mockGetTvWatchListStatus,
      saveTvWatchlist: mockSaveTvWatchlist,
      removeTvWatchlist: mockRemoveTvWatchlist,
    );
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

  test('initial state should be empry', () {
    expect(watchlistTvBloc.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvEvents()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );

      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvEvents()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveTvWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(AddTvToWatchListEvents(testTvDetail)),
        expect: () => [
          WatchlistTvMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockSaveTvWatchlist.execute(testTvDetail));
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('can\'t add data to watchlist')),
          );
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(AddTvToWatchListEvents(testTvDetail)),
        expect: () => [
          WatchlistTvError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveTvWatchlist.execute(testTvDetail));
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(RemoveTvToWatchListEvents(testTvDetail)),
        expect: () => [
          WatchlistTvMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveTvWatchlist.execute(testTvDetail));
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(RemoveTvToWatchListEvents(testTvDetail)),
        expect: () => [
          WatchlistTvError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveTvWatchlist.execute(testTvDetail));
        },
      );
    },
  );
}
