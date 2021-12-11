// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/presentation/bloc/watchlist_movie_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;

import 'package:bloc/bloc.dart' as _i8;
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart' as _i2;
import 'package:ditonton/domain/usecases/get_watchlist_status.dart' as _i3;
import 'package:ditonton/domain/usecases/remove_watchlist.dart' as _i5;
import 'package:ditonton/domain/usecases/save_watchlist.dart' as _i4;
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetWatchlistMovies_0 extends _i1.Fake
    implements _i2.GetWatchlistMovies {}

class _FakeGetWatchListStatus_1 extends _i1.Fake
    implements _i3.GetWatchListStatus {}

class _FakeSaveWatchlist_2 extends _i1.Fake implements _i4.SaveWatchlist {}

class _FakeRemoveWatchlist_3 extends _i1.Fake implements _i5.RemoveWatchlist {}

class _FakeWatchlistMovieState_4 extends _i1.Fake
    implements _i6.WatchlistMovieState {}

/// A class which mocks [WatchlistMovieBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistMovieBloc extends _i1.Mock
    implements _i6.WatchlistMovieBloc {
  MockWatchlistMovieBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistMovies get getWatchlistMovies =>
      (super.noSuchMethod(Invocation.getter(#getWatchlistMovies),
          returnValue: _FakeGetWatchlistMovies_0()) as _i2.GetWatchlistMovies);
  @override
  set getWatchlistMovies(_i2.GetWatchlistMovies? _getWatchlistMovies) => super
      .noSuchMethod(Invocation.setter(#getWatchlistMovies, _getWatchlistMovies),
          returnValueForMissingStub: null);
  @override
  _i3.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
          returnValue: _FakeGetWatchListStatus_1()) as _i3.GetWatchListStatus);
  @override
  set getWatchListStatus(_i3.GetWatchListStatus? _getWatchListStatus) => super
      .noSuchMethod(Invocation.setter(#getWatchListStatus, _getWatchListStatus),
          returnValueForMissingStub: null);
  @override
  _i4.SaveWatchlist get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlist_2()) as _i4.SaveWatchlist);
  @override
  set saveWatchlist(_i4.SaveWatchlist? _saveWatchlist) =>
      super.noSuchMethod(Invocation.setter(#saveWatchlist, _saveWatchlist),
          returnValueForMissingStub: null);
  @override
  _i5.RemoveWatchlist get removeWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlist_3()) as _i5.RemoveWatchlist);
  @override
  set removeWatchlist(_i5.RemoveWatchlist? _removeWatchlist) =>
      super.noSuchMethod(Invocation.setter(#removeWatchlist, _removeWatchlist),
          returnValueForMissingStub: null);
  @override
  _i6.WatchlistMovieState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _FakeWatchlistMovieState_4()) as _i6.WatchlistMovieState);
  @override
  _i7.Stream<_i6.WatchlistMovieState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i6.WatchlistMovieState>.empty())
          as _i7.Stream<_i6.WatchlistMovieState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i6.WatchlistMovieEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i6.WatchlistMovieEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i6.WatchlistMovieState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i6.WatchlistMovieEvent>(
          _i8.EventHandler<E, _i6.WatchlistMovieState>? handler,
          {_i8.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i8.Transition<_i6.WatchlistMovieEvent, _i6.WatchlistMovieState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i7.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  void onChange(_i8.Change<_i6.WatchlistMovieState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
