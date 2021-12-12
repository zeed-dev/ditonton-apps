import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendatios.dart';
import 'package:ditonton/presentation/bloc/tv_recomendation_bloc/tv_recomendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late MockGetTvRecommendations mockGetTvRecommendations;
  late TvRecomendationBloc tvRecomendationBloc;

  const tId = 1;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecomendationBloc = TvRecomendationBloc(mockGetTvRecommendations);
  });

  test('the initial state should sbe empty', () {
    expect(tvRecomendationBloc.state, TvRecomendationEmpty());
  });

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvList));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetTvRecomendationEvent(tId)),
    expect: () => [
      TvRecomendationLoading(),
      TvRecomendationHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(tId));
    },
  );

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetTvRecomendationEvent(tId)),
    expect: () => [
      TvRecomendationLoading(),
      TvRecomendationError("Server Failure"),
    ],
    verify: (bloc) => TvRecomendationLoading(),
  );

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right([]));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetTvRecomendationEvent(tId)),
    expect: () => [
      TvRecomendationLoading(),
      TvRecomendationHasData([]),
    ],
    verify: (bloc) => TvRecomendationLoading(),
  );
}
