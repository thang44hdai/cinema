class Movie {
  String title;
  String overview;
  String poster_path;
  String popularity;
  String backdrop_path;
  String original_title;

  Movie({
    required this.title,
    required this.overview,
    required this.poster_path,
    required this.popularity,
    required this.backdrop_path,
    required this.original_title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"] ?? "false",
      overview: json["overview"] ?? "false",
      poster_path: json["poster_path"] ?? "false",
      popularity: json["popularity"] ?? "false",
      backdrop_path: json["backdrop_path"] ?? "false",
      original_title: json["original_title"] ?? "false",
    );
  }

  Map<String, dynamic> toJson() => {
        "title": this.title,
        "overview": this.overview,
        "poster_path": this.poster_path,
        "popularity": this.popularity,
        "backdrop_path": this.backdrop_path,
        "original_title": this.original_title,
      }; // return 1 map có key là String, value là String // dynamic
}
