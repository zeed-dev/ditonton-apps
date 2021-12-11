import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';

void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecomendationBloc movieRecomendationBloc;

  const tId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecomendationBloc =
        MovieRecomendationBloc(mockGetMovieRecommendations);
  });

  test('the initial state should sbe empty', () {
    expect(movieRecomendationBloc.state, MovieRecomendationEmpty());
  });

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetMovieRecomendationEvent(tId)),
    expect: () => [
      MovieRecomendationLoading(),
      MovieRecomendationHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetMovieRecomendationEvent(tId)),
    expect: () => [
      MovieRecomendationLoading(),
      MovieRecomendationError('Server Failure'),
    ],
    verify: (bloc) => MovieRecomendationLoading(),
  );

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async =>  Right([]));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetMovieRecomendationEvent(tId)),
    expect: () => [
      MovieRecomendationLoading(),
      MovieRecomendationHasData([]),
    ],
    verify: (bloc) => MovieRecomendationHasData([]),
  );
}
