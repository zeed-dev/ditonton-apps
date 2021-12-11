import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';

void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc movieDetailBloc;

  int tId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  test('the initial state should be empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
    verify: (bloc) => MovieDetailLoading(),
  );
}
