import 'dart:convert';

class SingleVideo {

  final int id;
  final int userId;
  final String title;
  final String slug;
  final String description;
  final int views;
  final String runtime;
  final String year;
  final String imdbId;
  final String imdbRating;
  final List<dynamic> genres;
  final List<dynamic> country;
  final String type;
  final List<dynamic> directors;
  final List<dynamic> actors;
  final String boxOffice;
  final String poster;
  final String video;
  final List<dynamic> photos;
  final String ageRating;
  final int likes;
  final int dislikes;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int likeStatus;
  final List<SimilarVideo> similarVideo;

  SingleVideo(
      {this.id,
        this.userId,
        this.title,
        this.slug,
        this.description,
        this.views,
        this.runtime,
        this.year,
        this.imdbId,
        this.imdbRating,
        this.genres,
        this.country,
        this.type,
        this.directors,
        this.actors,
        this.boxOffice,
        this.poster,
        this.video,
        this.photos,
        this.ageRating,
        this.likes,
        this.dislikes,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.likeStatus,
        this.similarVideo});

  SingleVideo.fromJson(Map<String, dynamic> data)
    : id = data['id'],
    userId = data['user_id'],
    title = data['title'],
    slug = data['slug'],
    description = data['description'],
    views = data['views'],
    runtime = data['runtime'],
    year = data['year'],
    imdbId = data['imdb_id'],
    imdbRating = data['imdb_rating'],
    genres =  json.decode(data['genres']),
    country = json.decode(data['country']),
    type = data['type'],
    directors = json.decode(data['directors']),
    actors = json.decode(data['actors']),
    boxOffice = data['box_office'],
    poster = data['poster'],
    video = data['video'],
    photos = json.decode(data['photos']),
    ageRating = data['age_rating'],
    likes = data['likes'],
    dislikes = data['dislikes'],
    status = data['status'],
    createdAt = data['created_at'],
    updatedAt = data['updated_at'],
    likeStatus = data["likeStatus"],
    similarVideo = (data["similarVideos"] as List).map((i) => new SimilarVideo.fromJson(i)).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['views'] = this.views;
    data['runtime'] = this.runtime;
    data['year'] = this.year;
    data['imdb_id'] = this.imdbId;
    data['imdb_rating'] = this.imdbRating;
    data['genres'] = this.genres;
    data['country'] = this.country;
    data['type'] = this.type;
    data['directors'] = this.directors;
    data['actors'] = this.actors;
    data['box_office'] = this.boxOffice;
    data['poster'] = this.poster;
    data['video'] = this.video;
    data['photos'] = this.photos;
    data['age_rating'] = this.ageRating;
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likeStatus'] = this.likeStatus;
    if (this.similarVideo != null) {
      data['similarVideos'] = this.similarVideo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikeStatus {
  final int status;

  LikeStatus({this.status});

  LikeStatus.fromJson(Map<String, dynamic> json) :
    status = json['status'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

class SimilarVideo {
  final int id;
  final String slug;
  final String title;
  final String imdbRating;
  final String type;
  final String genres;
  final String poster;

  SimilarVideo(
      {this.id,
        this.slug,
        this.title,
        this.imdbRating,
        this.type,
        this.genres,
        this.poster});

  SimilarVideo.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    slug = json['slug'],
    title = json['title'],
    imdbRating = json['imdb_rating'],
    type = json['type'],
    genres = json['genres'],
    poster = json['poster'];

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