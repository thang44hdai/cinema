import 'dart:convert';
import 'package:cinema/models/constants.dart';
import '../models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  String trendingUrl = "${Constants.trendingUrl}${Constants.apiKey}";
  String isPlayingUrl = "${Constants.isPlayingUrl}${Constants.apiKey}";
  String upComingUrl = "${Constants.upComingUrl}${Constants.apiKey}";

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trendingUrl));
    if (response.statusCode == 200) {
      final List<dynamic> decodeData = json.decode(response.body)['results'];
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Something happend");
    }
  }

  Future<List<Movie>> getIsPlayingMovies() async {
    final response = await http.get(Uri.parse(isPlayingUrl));
    if (response.statusCode == 200) {
      final List<dynamic> decodeData = json.decode(response.body)['results'];
      return decodeData.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception("Error");
    }
  }

  Future<List<Movie>> getUpComingMovies() async {
    final respone = await http.get(Uri.parse(upComingUrl));
    if (respone.statusCode == 200) {
      final List<dynamic> decodeData = json.decode(respone.body)['results'];
      return decodeData.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception("Error");
    }
  }
}
