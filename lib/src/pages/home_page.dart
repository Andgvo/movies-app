import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/serach/search_delegate.dart';
import 'package:movies/src/widget/card_swiper_widget.dart';
import 'package:movies/src/widget/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final _moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    _moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon( Icons.search),
            onPressed: (){
              showSearch(
                context: context,
                delegate: DataSerach(),
                // query: 'Hola' //Preload info, like 'Helo' in search bar
              );
            }
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _cardSwiper(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder<List<Movie>>(
      future: _moviesProvider.getPlayingNow(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if( snapshot.hasData ){
          return CardSwiper( movies: snapshot.data );
        }
        return Container(
          height: 400.0,
          child: Center( 
            child: CircularProgressIndicator()
          )
        );
      },
    );

    //return CardSwiper(movies: [1,2,3,4,5]);
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text('Populares', style: Theme.of(context).textTheme.subtitle1,),
          SizedBox(height: 5.0,),
          _createPopular()
        ],
      ),
    );
  }

  _createPopular(){
    return StreamBuilder<List<Movie>>(
      stream: _moviesProvider.popularsStream,
      builder: (context, snapshot){
        if( snapshot.hasData )
          return MovieHorizontal(movies: snapshot.data, nextPage: _moviesProvider.getPopular, );
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}