import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';
import '../provider/watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([WatchlistMovieBloc])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = <Movie>[tMovieModel];
  test('initial state should be empry', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMovieEvents()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Server Failure")),
      );

      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMovieEvents()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlistEvents(testMovieDetail)),
        expect: () => [
          WatchlistMovieMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('can\'t add data to watchlist')),
          );
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlistEvents(testMovieDetail)),
        expect: () => [
          WatchlistMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlistEvents(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieToWatchlistEvents(testMovieDetail)),
        expect: () => [
          WatchlistMovieMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieToWatchlistEvents(testMovieDetail)),
        expect: () => [
          WatchlistMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        },
      );
    },
  );
}
