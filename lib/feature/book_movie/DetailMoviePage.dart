import 'dart:convert';

import 'package:flutix_app/feature/book_movie/ChooseVenuePage.dart';
import 'package:flutix_app/model/CastModel.dart';
import 'package:flutix_app/model/GenreModel.dart';
import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/BookedMovieModel.dart';
import '../../model/DetailMovieModel.dart';
import '../../model/HistoryTransactions.dart';
import '../../model/SpokenLanguages.dart';
import '../../model/User.dart';

class DetailMoviePage extends StatefulWidget {
  final TabController tabController;
  final User user;
  final MovieModel movie;
  final double saldo;
  final List<BookedMovieModel> bookedMovieHistory;
  final List<HistoryTransactions> historyTransaction;
  const DetailMoviePage({Key? key, required this.movie, required this.saldo, required this.user, required this.tabController, required this.bookedMovieHistory, required this.historyTransaction}) : super(key: key);

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  List<CastModel> castMembers = [];
  bool isLoading = false;
  @override
  void initState() {
    getDataDetailMovieAPI();

    super.initState();

  }

  getDataDetailMovieAPI() async {
    isLoading = true;
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${widget.movie.id}?api_key=d3c370e7fe51dfcd86bd698f8a3b8b32&language=en-US'));
    if(response.statusCode == 200){
      //masukin data genres
      List tmp = json.decode(response.body)['genres'];
      widget.movie.genres!.clear(); //list di hapus dlu biar klo get data lainnya tidak numpuk/double
      tmp.forEach((element) {
        widget.movie.genres!.add(GenreModel.fromJson(element));
      });

      //masukin data spoken language
      List tempLang = json.decode(response.body)['spoken_languages'];
      widget.movie.lang!.clear(); //list di hapus dlu biar klo get data lainnya tidak numpuk/double
      tempLang.forEach((element) {
        widget.movie.lang!.add(SpokenLanguage.fromJson(element));
      });


    }
    else{
      print(response.body);
    }


    //api cast member
    final responseCast = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${widget.movie.id}/credits?api_key=d3c370e7fe51dfcd86bd698f8a3b8b32&language=en-US'));
    if(responseCast.statusCode == 200){
      //masukin data genres
      var a = responseCast.body;
      List tempCast = json.decode(responseCast.body)['cast'];
      tempCast.forEach((element) {
        castMembers.add(CastModel.fromJson(element));
      });
    }
    else{
      print(response.body);
    }
    isLoading = false;
    setState(() { });
  }

  getStar(MovieModel movie){
    List<Widget> stars = [];
    int tmp = (movie.voteAverage! / 2).toInt(); // rating max 10, bintang max ada 5
    for(var i = 0; i<tmp; i++){
      stars.add(
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Icon(Icons.star, color: Color(0XFFFBD361), size: 20,),
          )
      );
    }
    if(stars.length < 5){ //cek klo bintangnya belum 5 berarti kasih bintang kosong
      int sisa = 5 - stars.length;
      for(var i = 0; i<sisa; i++){
        stars.add(
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Icon(Icons.star_border_rounded, color: Color(0XFFFBD361), size: 20,),
            )
        );
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [

                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage("http://image.tmdb.org/t/p/w500${widget.movie.posterPath}"),
                            fit: BoxFit.cover,
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.black.withOpacity(0),
                                Colors.white
                              ])
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.black.withOpacity(0),
                                Colors.white
                              ])
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text('${widget.movie.title}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 8,),

                isLoading ? Center(child: CircularProgressIndicator(),) :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var i = 0; i < widget.movie.genres!.length; i++)
                    Text('${widget.movie.genres![i].name}${i == widget.movie.genres!.length-1 ? '': ', '}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                    ),

                    Text(' - ${widget.movie.lang!.first.name}',// ambil list "lang" yang pertama
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: getStar(widget.movie), //karena return dari fungsi sudah list maka tidak perlu tnda []
                    ),
                    Row(
                      children: [
                        SizedBox(width: 3,),
                        Text('${widget.movie.voteAverage!.toStringAsFixed(1)}/10', style: TextStyle(color: Colors.grey, fontSize: 12),)

                      ],
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,32,20,20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cast & Crew', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                  SizedBox(height: 11,),

                  isLoading ? Center(child: CircularProgressIndicator(),) :
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(var i = 0; i < 7; i++) //ini looping sampai 8 karena di flutix pak Erico hanya 8 cast teratas yang dimunculin
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 75,
                            child: Column(
                              children: [
                                Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage("http://image.tmdb.org/t/p/w500${castMembers[i].profilePath}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6,),
                                Text('${castMembers[i].name}', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text('Storyline', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                  SizedBox(height: 8,),
                  Text('${widget.movie.overview}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.grey),),
                ],
              ),
            ),
            SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseVenuePage(user: widget.user, movie: widget.movie, saldo: widget.saldo, tabController: widget.tabController, bookedMovieHistory: widget.bookedMovieHistory, historyTransaction: widget.historyTransaction,)));
                  },
                  constraints: BoxConstraints(minWidth: 220, minHeight: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  fillColor: Color(0XFF382A75),
                  child: Text('Continue to Book', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
