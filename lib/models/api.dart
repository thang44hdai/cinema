import 'dart:convert';

import 'package:cinema/models/constants.dart';
import 'movie.dart';
import 'package:http/http.dart' as http;

class Api {
  String trendingUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=${Constaints.apiKey}";

  Future<List<Movie>> getTredingMovies() async {
    final response = await http.get(Uri.parse(trendingUrl));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['result'] as List;
      return decodeData.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception("Something happend");
    }
  }
}
