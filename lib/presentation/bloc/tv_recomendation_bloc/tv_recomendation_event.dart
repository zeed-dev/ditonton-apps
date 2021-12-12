part of 'tv_recomendation_bloc.dart';

abstract class TvRecomendationEvent extends Equatable {
  const TvRecomendationEvent();

  @override
  List<Object> get props => [];
}

class GetTvRecomendationEvent extends TvRecomendationEvent {
  final int id;

  GetTvRecomendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
