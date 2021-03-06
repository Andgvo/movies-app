class Cast{
  List<Actor> cast;

  Cast.fromJsonList( List<dynamic> jsonList ){
    if( jsonList == null ) return;
    cast = jsonList.map((actor) => Actor.fromJsonMap(actor)).toList();
  }
}


class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> json){
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  String getPhoto(){
    if(profilePath == null )
      return 'https://consumiblesreyccom.com/contentimg/nopic.png';
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}