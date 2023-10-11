import 'movie.dart';

class MovieResponse {
  List<Movie> movies = [];
  String error = "";

  MovieResponse(this.movies, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies =
            (json["result"] as List).map((e) => new Movie.fromJson(e)).toList(),
        error = "";
  MovieResponse.withError()
}
