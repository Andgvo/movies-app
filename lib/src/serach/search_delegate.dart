import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSerach extends SearchDelegate{

  String _selection = '';
  final _moviesProvider = new MoviesProvider();

  final movies = [
    'Spiderman',
    'Tom y Jerry'
  ];

  final playingNowMovies = [
    'Spiderman',
    'Captain America'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon left of AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ), 
      onPressed: (){
        close( context, null );
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(_selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if( query.isEmpty ) return Container();

    return FutureBuilder(
      future: _moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if( snapshot.hasData ){
          final movies = snapshot.data;
          return ListView(
            children: movies.map((movie){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage( movie.getPosterImg() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text( movie.originalTitle ),
                onTap: (){
                  close(context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'details', arguments: movie);
                },
              );
            }).toList(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  /* @override
  Widget buildSuggestions(BuildContext context) {

    final suggestList = (query.isEmpty ) ? playingNowMovies : movies.where((movie) => movie.toLowerCase().startsWith(query.toLowerCase())).toList();

    // Suggestions that apears when user are writing
    return ListView.builder(
      itemCount: suggestList.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestList[i]),
          onTap: () {
            _selection = suggestList[i];
            showResults(context);
          },
        );
      },
    ); 
  }*/

}