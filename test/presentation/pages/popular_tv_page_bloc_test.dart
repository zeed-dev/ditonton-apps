import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular_bloc/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesPopularBloc
    extends MockBloc<TvSeriesPopularEvent, TvSeriesPopularState>
    implements TvSeriesPopularBloc {}

class TvSeriesPopularEventFake extends Fake implements TvSeriesPopularEvent {}

class TvSeriesPopularStateFake extends Fake implements TvSeriesPopularState {}

@GenerateMocks([TvSeriesPopularBloc])
void main() {
  late MockTvSeriesPopularBloc mockTvSeriesPopularBloc;

  setUpAll(() {
    registerFallbackValue(TvSeriesPopularEventFake());
    registerFallbackValue(TvSeriesPopularStateFake());
  });

  setUp(() {
    mockTvSeriesPopularBloc = MockTvSeriesPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesPopularBloc>(
      create: (_) => mockTvSeriesPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(() => mockTvSeriesPopularBloc.state)
        .thenReturn(TvSeriesPopularLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (
    WidgetTester tester,
  ) async {
    when(() => mockTvSeriesPopularBloc.stream).thenAnswer(
      (_) => Stream.value(TvSeriesPopularHashData(tTvList)),
    );

    when(() => mockTvSeriesPopularBloc.state)
        .thenReturn(TvSeriesPopularHashData(tTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(() => mockTvSeriesPopularBloc.stream).thenAnswer(
      (_) => Stream.value(TvSeriesPopularError("Error Message")),
    );

    when(() => mockTvSeriesPopularBloc.state)
        .thenReturn(TvSeriesPopularError("Error Message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
