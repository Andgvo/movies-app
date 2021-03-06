import 'dart:async';
import 'dart:convert';

import 'package:movies/src/models/actors_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = 'bb7f2c67dc986be31571f9ecf500f39d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = [];
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  void disposeStreams(){
    _popularsStreamController?.close();
  }

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  Future<List<Movie>> getPlayingNow() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language
    });

    return await getGeneric(url);
  } 
    
  Future<List<Movie>> getPopular() async {
    
    if(_loading) return [];

    _loading = true;

    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language': _language,
      'page'    : _popularsPage.toString()
    });

    final resp = await getGeneric(url);
    _populars.addAll(resp);
    popularsSink(_populars);

    _loading = false;

    return resp; 
  }
  
  Future<List<Movie>> getGeneric(Uri url) async {    
    final res = await http.get(url);
    final decodeData = json.decode(res.body);
    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key' : _apikey,
      'language': _language,
    });
    
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodeData['cast']);
    
    return cast.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query
    });

    return await getGeneric(url);
  } 
    
}