import 'package:nx_play/src/models/links.dart';

class GetMoreVideos {
  final int currentPage;
   List<VideosData> videosData;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Links> links;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  GetMoreVideos(
      {this.currentPage,
      this.videosData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  void clearVideosData(){
    videosData.clear();
  }

  GetMoreVideos.fromJson(Map<String, dynamic> json) :
    currentPage = json['current_page'],
    videosData = (json["data"] as List).map((i) => new VideosData.fromJson(i)).toList(),
    firstPageUrl = json['first_page_url'],
    from = json['from'],
    lastPage = json['last_page'],
    lastPageUrl = json['last_page_url'],
    links = (json["links"] as List).map((i) => new Links.fromJson(i)).toList(),
    nextPageUrl = json['next_page_url'],
    path = json['path'],
    perPage = json['per_page'],
    prevPageUrl = json['prev_page_url'],
    to = json['to'],
    total = json['total'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.videosData != null) {
      data['data'] = this.videosData.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class VideosData {
  final int id;
  final String slug;
  final String title;
  final String description;
  final int views;
  final String runtime;
  final String year;
  final String imdbRating;
  final String type;
  final String genres;
  final String country;
  final String directors;
  final String actors;
  final String poster;
  final String ageRating;

  VideosData(
      {this.id,
      this.slug,
      this.title,
      this.description,
      this.views,
      this.runtime,
      this.year,
      this.imdbRating,
      this.type,
      this.genres,
      this.country,
      this.directors,
      this.actors,
      this.poster,
      this.ageRating});

  VideosData.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    slug = json['slug'],
    title = json['title'],
    description = json['description'],
    views = json['views'],
    runtime = json['runtime'],
    year = json['year'],
    imdbRating = json['imdb_rating'],
    type = json['type'],
    genres = json['genres'],
    country = json['country'],
    directors = json['directors'],
    actors = json['actors'],
    poster = json['poster'],
    ageRating = json['age_rating'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['views'] = this.views;
    data['runtime'] = this.runtime;
    data['year'] = this.year;
    data['imdb_rating'] = this.imdbRating;
    data['type'] = this.type;
    data['genres'] = this.genres;
    data['country'] = this.country;
    data['directors'] = this.directors;
    data['actors'] = this.actors;
    data['poster'] = this.poster;
    data['age_rating'] = this.ageRating;
    return data;
  }
}
