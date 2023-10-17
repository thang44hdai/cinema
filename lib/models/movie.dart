class Movie {
  String title;
  String backdrop_path;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String vote_average;
  String popularity;
  String vote_count;

  Movie({
    required this.title,
    required this.backdrop_path,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.vote_average,
    required this.popularity,
    required this.vote_count,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"] ?? "false",
      backdrop_path: json["backdrop_path"] ?? "false",
      original_title: json["original_title"] ?? "false",
      overview: json["overview"] ?? "false",
      poster_path: json["poster_path"] ?? "false",
      release_date: json["release_date"] ?? "false",
      vote_average: json["vote_average"].toString() ?? "false",
      popularity: json['popularity'].toString() ?? "false",
      vote_count: json['vote_count'].toString() ?? "false",
    );
  }
}
