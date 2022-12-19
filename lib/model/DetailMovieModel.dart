import 'GenreModel.dart';
import 'SpokenLanguages.dart';

class DetailMovieModel {
  String? backdropPath;
  int? budget;
  List<GenreModel>? genres;
  int? id;
  String? originalLanguage;
  String? overview;
  String? releaseDate;
  List<SpokenLanguage>? spokenLanguages;
  String? tagline;
  double? voteAverage;

  DetailMovieModel(
      {this.backdropPath,
        this.budget,
        this.genres,
        this.id,
        this.originalLanguage,
        this.overview,
        this.releaseDate,
        this.spokenLanguages,
        this.tagline,
        this.voteAverage});

  DetailMovieModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = <GenreModel>[];
      json['genres'].forEach((v) {
        genres!.add(GenreModel.fromJson(v));
      });
    }
    id = json['id'];
    originalLanguage = json['original_language'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguage>[];
      json['spoken_languages'].forEach((v) {
        spokenLanguages!.add(SpokenLanguage.fromJson(v));
      });
    }
    tagline = json['tagline'];
    voteAverage = json['vote_average'].runtimeType != double ? json['vote_average'].toDouble() : json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['budget'] = budget;
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    if (this.spokenLanguages != null) {
      data['spoken_languages'] =
          this.spokenLanguages!.map((v) => v.toJson()).toList();
    }
    data['tagline'] = this.tagline;
    data['vote_average'] = this.voteAverage;
    return data;
  }
}