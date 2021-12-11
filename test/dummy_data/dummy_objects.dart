import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

/// TV
final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTvDetail = TvDetail(
  backdropPath: "/pkOSjcllDSs4WP9i8DGkw9VgF5Q.jpg",
  episodeRunTime: [45],
  genres: [
    Genre(id: 10764, name: "10764"),
    Genre(id: 10751, name: "Family"),
  ],
  homepage:
      "https://www.daserste.de/unterhaltung/quiz-show/wer-weiss-denn-sowas/index.htmlWho",
  id: 1,
  inProduction: true,
  name: "Wer weiß denn sowas?",
  numberOfEpisodes: 784,
  numberOfSeasons: 7,
  originalLanguage: "de",
  originalName: "Wer weiß denn sowas?",
  overview: "",
  popularity: 1970.517,
  posterPath: "/abKjah96esLWObidBcWmvKJv61E.jpg",
  status: "Returning Series",
  tagline: "",
  type: "Scripted",
  voteAverage: 8.0,
  voteCount: 7,
);

final testTvDetailDua = TvDetail(
  backdropPath: "/pkOSjcllDSs4WP9i8DGkw9VgF5Q.jpg",
  episodeRunTime: [45],
  genres: [
    Genre(id: 10764, name: "10764"),
    Genre(id: 10751, name: "Family"),
  ],
  homepage:
      "https://www.daserste.de/unterhaltung/quiz-show/wer-weiss-denn-sowas/index.htmlWho",
  id: 1,
  inProduction: true,
  name: "name",
  numberOfEpisodes: 784,
  numberOfSeasons: 7,
  originalLanguage: "de",
  originalName: "Wer weiß denn sowas?",
  overview: "overview",
  popularity: 1970.517,
  posterPath: "posterPath",
  status: "Returning Series",
  tagline: "",
  type: "Scripted",
  voteAverage: 8.0,
  voteCount: 7,
);
