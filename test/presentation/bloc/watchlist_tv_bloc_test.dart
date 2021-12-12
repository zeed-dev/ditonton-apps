import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
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
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    watchlistTvBloc = WatchlistTvBloc(
      getWatchlistTv: mockGetWatchlistTv,
      getTvWatchListStatus: mockGetTvWatchListStatus,
      saveTvWatchlist: mockSaveTvWatchlist,
      removeTvWatchlist: mockRemoveTvWatchlist,
    );
  });

  final tTvList = <Tv>[tTv];

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
}
