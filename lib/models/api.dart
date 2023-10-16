import 'dart:convert';
import 'package:cinema/models/constants.dart';
import 'movie.dart';
import 'package:http/http.dart' as http;

class Api {
  String trendingUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}";

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trendingUrl));
    if (response.statusCode == 200) {
      final List<dynamic> decodeData = json.decode(response.body)['results'];
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Something happend");
    }
  }
}
