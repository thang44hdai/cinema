import 'package:cinema/models/user.dart';

class Constants {
  static String apiKey = '7f87447bf2dcdd1a6bd4f041f2bb10f9';
  static String trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=';
  static String isPlayingUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=';
  static String upComingUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=';
  static String imagePath = 'https://image.tmdb.org/t/p/original';
  static String logo = 'https://homepage.momocdn.net/img/momo-upload-api-210907102204-637666069244403461.png';
  static user User = user(name: "name", account: "account", password: "password", ticket: []);
}
