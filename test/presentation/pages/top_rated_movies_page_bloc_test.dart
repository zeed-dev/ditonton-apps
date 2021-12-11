import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/toprated_movie_bloc/toprated_movie_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopratedMovieBloc
    extends MockBloc<TopratedMovieEvent, TopratedMovieState>
    implements TopratedMovieBloc {}

class TopratedMovieEventFake extends Fake implements TopratedMovieEvent {}

class TopratedMovieStateFake extends Fake implements TopratedMovieState {}

@GenerateMocks([TopratedMovieBloc])
void main() {
  late MockTopratedMovieBloc mockTopratedMovieBloc;

  setUpAll(() {
    registerFallbackValue(TopratedMovieEventFake());
    registerFallbackValue(TopratedMovieStateFake());
  });

  setUp(() {
    mockTopratedMovieBloc = MockTopratedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopratedMovieBloc>(
      create: (_) => mockTopratedMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(() => mockTopratedMovieBloc.state).thenReturn(TopRatedMovieLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (
    WidgetTester tester,
  ) async {
    when(() => mockTopratedMovieBloc.stream).thenAnswer(
      (_) => Stream.value(TopRatedMovieHasData(testMovieList)),
    );

    when(() => mockTopratedMovieBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(() => mockTopratedMovieBloc.stream).thenAnswer(
      (_) => Stream.value(TopRatedMovieError("Error Message")),
    );

    when(() => mockTopratedMovieBloc.state)
        .thenReturn(TopRatedMovieError("Error Message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
