import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendatios.dart';
import 'package:ditonton/domain/usecases/get_tv_season.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvSeason getTvSeason;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;
  final GetTvWatchListStatus getTvWatchListStatus;
  final GetTvRecommendations getTvRecommendations;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvSeason,
    required this.saveTvWatchlist,
    required this.removeTvWatchlist,
    required this.getTvWatchListStatus,
    required this.getTvRecommendations,
  });

  late TvDetail _tv;
  TvDetail get tv => _tv;

  late Season _season;
  Season get season => _season;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  RequestState _seasonState = RequestState.Empty;
  RequestState get seasonState => _seasonState;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recomedation = await getTvRecommendations.execute(id);
    final season = await getTvSeason.execute(id);

    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _seasonState = RequestState.Loading;
        _tv = tv;
        notifyListeners();

        season.fold((failure) {
          _seasonState = RequestState.Error;
          _message = failure.message;
        }, (r) {
          _recommendationState = RequestState.Loading;
          _season = r;
          notifyListeners();

          recomedation.fold((l) {
            _seasonState = RequestState.Error;
            _message = l.message;
          }, (r) {
            _tvRecommendations = r;
            _recommendationState = RequestState.Loaded;
            notifyListeners();
          });
        });

        _seasonState = RequestState.Loaded;
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveTvWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeTvWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
