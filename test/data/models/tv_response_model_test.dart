import 'dart:convert';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    firstAirDate: "2021-11-24",
    name: "Hawkeye",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Hawkeye",
    backdropPath: "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
    genreIds: [10759, 18],
    id: 88329,
    overview:
        "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
    popularity: 5530.564,
    posterPath: "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
    voteAverage: 8.6,
    voteCount: 616,
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
            "first_air_date": "2021-11-24",
            "genre_ids": [10759, 18],
            "id": 88329,
            "name": "Hawkeye",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Hawkeye",
            "overview":
                "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
            "popularity": 5530.564,
            "poster_path": "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
            "vote_average": 8.6,
            "vote_count": 616
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
