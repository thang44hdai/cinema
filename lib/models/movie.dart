class Movie {
  int id = 0;
  double popularity = 0.0;
  String title = "";
  String backPoster = "";
  String poster = "";
  String overview = "";
  double rating = 0;

  Movie(this.id, this.popularity, this.title, this.backPoster, this.poster,
      this.overview, this.rating);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        popularity = json['popularity'],
        title = json['title'],
        backPoster = json['backPoster'],
        poster = json['poster'],
        overview = json['overview'],
        rating = json['rating'];
}
