import 'package:flutix_app/model/GenreModel.dart';
import 'package:flutix_app/model/SpokenLanguages.dart';

class MovieModel {
  String? backdropPath;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  double? voteAverage;
  List<int>? genreIds;
  List<GenreModel>? genres = [];
  List<SpokenLanguage>? lang = [];

  MovieModel(
      {this.backdropPath,
        this.id,
        this.title,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.voteAverage,
        this.genreIds,
        this.genres,
        this.lang
      });

  MovieModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'].runtimeType != double ? json['vote_average'].toDouble() : json['vote_average'];
    genreIds = json['genre_ids'].cast<int>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['id'] = this.id;
    data['title'] = this.title;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['vote_average'] = this.voteAverage;
    data['genre_ids'] = this.genreIds;
    return data;
  }
}