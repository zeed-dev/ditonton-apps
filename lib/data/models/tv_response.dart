import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  TvResponse({
    required this.tvList,
  });

  final List<TvModel> tvList;

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvList: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) =>
                element.backdropPath != null &&
                element.overview != "" &&
                element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvList];
}
