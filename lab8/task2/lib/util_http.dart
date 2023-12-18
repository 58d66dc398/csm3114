import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'model_movie.dart';

class HttpHelper {
  final String? key = dotenv.env['API_KEY'];
  final String api = 'https://api.themoviedb.org/3/',
      routeSoon = 'movie/upcoming',
      routeSearch = 'search/movie',
      queryAuth = 'api_key=',
      querySearch = 'query=',
      queryLang = 'language=en-US';

  Future<List?> getUpcoming() async {
    final uriSoon = '$api$routeSoon?$queryAuth${key!}&$queryLang';
    var url = Uri.parse(uriSoon);
    var result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      print(result.statusCode);
      final jsonRes = json.decode(result.body);
      final moviesMap = jsonRes['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List?> findMovies(String title) async {
    final String uriFind =
        '$api$routeSearch?$queryAuth${key!}&$querySearch$title';
    var url = Uri.parse(uriFind);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      print(result.statusCode);
      final jsonRes = json.decode(result.body);
      final moviesMap = jsonRes['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
