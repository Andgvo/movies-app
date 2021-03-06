class Movies {
  List<Movie> items = [];

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList ){
    if(jsonList == null ) return;
    for( var item in jsonList ){
      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }

}

class Movie {

  String uniqueId; 
  
  int id;
  int voteCount;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Movie({
    this.id,
    this.voteCount,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    voteCount = json['vote_count'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  String getPosterImg(){
    if(posterPath == null )
      return 'https://consumiblesreyccom.com/contentimg/nopic.png';
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String getBackgroundImg(){
    if(posterPath == null )
      return 'https://consumiblesreyccom.com/contentimg/nopic.png';
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }
}
