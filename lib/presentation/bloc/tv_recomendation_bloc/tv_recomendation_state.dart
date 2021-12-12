part of 'tv_recomendation_bloc.dart';

abstract class TvRecomendationState extends Equatable {
  const TvRecomendationState();

  @override
  List<Object> get props => [];
}

class TvRecomendationEmpty extends TvRecomendationState {
  @override
  List<Object> get props => [];
}

class TvRecomendationLoading extends TvRecomendationState {
  @override
  List<Object> get props => [];
}

class TvRecomendationError extends TvRecomendationState {
  final String message;

  TvRecomendationError(this.message);

  @override
  List<Object> get props => [];
}

class TvRecomendationHasData extends TvRecomendationState {
  final List<Tv> result;

  TvRecomendationHasData(this.result);

  @override
  List<Object> get props => [];
}
