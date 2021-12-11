import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class FakeMovieRecomendationBloc
    extends MockBloc<MovieRecomendationEvent, MovieRecomendationState>
    implements MovieRecomendationBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeWatchlistMoviesEvent extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMovieState {}

class FakeMovieRecommendationsEvent extends Fake
    implements MovieRecomendationEvent {}

class FakeMovieRecommendationsState extends Fake
    implements MovieRecomendationState {}

@GenerateMocks([MovieDetailBloc, WatchlistMovieBloc, MovieRecomendationBloc])
void main() {
  late FakeMovieDetailBloc fakeMovieDetailBloc;
  late FakeWatchlistMovieBloc fakeWatchlistMovieBloc;
  late FakeMovieRecomendationBloc fakeMovieRecomendationBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    fakeMovieDetailBloc = FakeMovieDetailBloc();

    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());
    fakeWatchlistMovieBloc = FakeWatchlistMovieBloc();

    registerFallbackValue(FakeMovieRecommendationsEvent());
    registerFallbackValue(FakeMovieRecommendationsState());
    fakeMovieRecomendationBloc = FakeMovieRecomendationBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => fakeMovieDetailBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => fakeWatchlistMovieBloc,
        ),
        BlocProvider<MovieRecomendationBloc>(
          create: (_) => fakeMovieRecomendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeMovieDetailBloc.close();
    fakeWatchlistMovieBloc.close();
    fakeMovieRecomendationBloc.close();
  });

  int tId = 1;

  testWidgets('Page should display progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(() => fakeMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieLoading());
    when(() => fakeMovieRecomendationBloc.state)
        .thenReturn(MovieRecomendationLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: tId,
    )));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (
    WidgetTester tester,
  ) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(MovieIsAddedToWatchList(false));
    when(() => fakeMovieRecomendationBloc.state)
        .thenReturn(MovieRecomendationHasData(testMovieList));

    final watchlistButtonIconFinder = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: tId,
    )));

    expect(watchlistButtonIconFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(MovieIsAddedToWatchList(true));
    when(() => fakeMovieRecomendationBloc.state)
        .thenReturn(MovieRecomendationHasData(testMovieList));

    final watchlistButtonIconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: tId,
    )));

    expect(watchlistButtonIconFinder, findsOneWidget);
  });
}
