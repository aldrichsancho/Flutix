import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutix_app/model/SeatModel.dart';
import 'package:flutix_app/model/TimeModel.dart';

import 'ChooseDateModel.dart';

class BookedMovieModel{
  MovieModel movie;
  List<SeatModel> seat;
  TimeModel timeAndVenue;
  double total;
  ChooseDateModel date;

  BookedMovieModel({required this.movie, required this.seat, required this.timeAndVenue, required this.total, required this.date});
}