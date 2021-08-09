import 'dart:convert';

class Videos {
  final int id;
  final String slug;
  final String title;
  final String imdbRating;
  final String type;
  final List<dynamic> genres;
  final String poster;

  Videos(
      {this.id,
        this.slug,
        this.title,
        this.imdbRating,
        this.type,
        this.genres,
        this.poster});

  Videos.fromJson(Map<String, dynamic> data):
        id = data['id'],
        slug =data['slug'],
        title =data['title'],
        imdbRating =data['imdb_rating'],
        type =data['type'],
        genres = json.decode(data['genres']),
        poster =data['poster'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['imdb_rating'] = this.imdbRating;
    data['type'] = this.type;
    data['genres'] = this.genres;
    data['poster'] = this.poster;
    return data;
  }
}
