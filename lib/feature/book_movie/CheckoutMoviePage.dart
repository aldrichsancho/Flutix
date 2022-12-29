import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutix_app/model/SeatModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/BookedMovieModel.dart';
import '../../model/ChooseDateModel.dart';
import '../../model/HistoryTransactions.dart';
import '../../model/TimeModel.dart';
import '../../model/User.dart';
import 'SuccessBookedPage.dart';

class CheckoutMoviePage extends StatefulWidget {
  final TabController tabController;
  final User user;
  final MovieModel movie;
  final double saldo;
  final ChooseDateModel date;
  final TimeModel venueAndTime;
  final List<SeatModel> choosenSeats;
  final List<BookedMovieModel> bookedMovieHistory;
  final List<HistoryTransactions> historyTransaction;
  const CheckoutMoviePage({Key? key, required this.movie, required this.saldo, required this.date, required this.venueAndTime, required this.choosenSeats, required this.user, required this.tabController, required this.bookedMovieHistory, required this.historyTransaction}) : super(key: key);

  @override
  State<CheckoutMoviePage> createState() => _CheckoutMoviePageState();
}

class _CheckoutMoviePageState extends State<CheckoutMoviePage> {
  String seatNumbers = '';
  double total = 0;

  @override
  void initState() {
    getSeatNumbers();
    getTotal();
    super.initState();

  }

  String moneyFormat(double amount) {
    if (amount == null) return '0';
    return NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
        .format(amount);
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

  leftRightComponent(String textLeft, String textRight, {bool? bold}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5 - 40,
          child: Text(textLeft, style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),)
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.5 - 40,
          child: Text(textRight, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: bold != null ? FontWeight.w400 : FontWeight.w300),textAlign: TextAlign.right,)
        ),
      ],
    );
  }

  getSeatNumbers(){
    for(var i = 0; i < widget.choosenSeats.length; i++){
      if(i != widget.choosenSeats.length){
        seatNumbers += '${widget.choosenSeats[i].number}, ';
      }
      else{
        seatNumbers += '${widget.choosenSeats[i].number}';
      }
    }
  }
  
  getTotal(){
    double subtotal = widget.choosenSeats.length * 25000;
    double totalFee = widget.choosenSeats.length * 1500;
    total = subtotal + totalFee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0XFF262626),
        ),
        backgroundColor: Colors.white,
        title: Text('Checkout \nMovie', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Color(0XFF262626)), textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Container(
                    height: 90,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage("http://image.tmdb.org/t/p/w500${widget.movie.posterPath}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.movie.title}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      SizedBox(height: 6,),
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
                      SizedBox(height: 6,),
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
                  )
                ],
              ),
              SizedBox(height: 30,),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Color(0XFFE4E4E4),
              ),
              SizedBox(height: 40,),
              leftRightComponent('Order Id', '5oY78L38TjLj'),
              SizedBox(height: 12,),
              leftRightComponent('Cinema', '${widget.venueAndTime.venue}'),
              SizedBox(height: 12,),
              leftRightComponent('Date & Time', '${widget.date.name} ${widget.date.day}, ${widget.venueAndTime.time}'),
              SizedBox(height: 12,),
              leftRightComponent('Seats Number', seatNumbers),
              SizedBox(height: 12,),
              leftRightComponent('Price', 'IDR 25.000 x ${widget.choosenSeats.length}'),
              SizedBox(height: 12,),
              leftRightComponent('Fee', 'IDR 1.500 x ${widget.choosenSeats.length}'),
              SizedBox(height: 12,),
              leftRightComponent('Total', 'IDR ${moneyFormat(total)}',bold: true),
              SizedBox(height: 40,),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Color(0XFFE4E4E4),
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 40,
                      child: Text('Your Wallet', style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),)
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 40,
                      child: Text('IDR ${moneyFormat(widget.saldo)}', style: TextStyle(color: (widget.saldo - total < 0) ? Colors.pink : Colors.teal, fontSize: 18, fontWeight: FontWeight.w400,),textAlign: TextAlign.right,)
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Center(
                child: RawMaterialButton(
                  onPressed: (){
                    if(widget.saldo - total > 0){
                      widget.bookedMovieHistory.add(
                          BookedMovieModel(
                              movie: widget.movie,
                              seat: widget.choosenSeats,
                              timeAndVenue: widget.venueAndTime,
                              date: widget.date,
                              total: total)
                      );
                      widget.historyTransaction.add(
                        HistoryTransactions(
                          type: "movie",
                          name: "${widget.movie.title}",
                          nominal: total,
                          photo: "${widget.movie.posterPath}",
                          description: "${widget.venueAndTime.venue}"
                        )
                      );
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuccessBookedPage(user: widget.user, venueAndTime: widget.venueAndTime, date: widget.date, movie: widget.movie,newSaldoTotal: widget.saldo - total, choosenSeats: widget.choosenSeats, tabController: widget.tabController, bookedMovieHistory: widget.bookedMovieHistory, historyTransaction: widget.historyTransaction)));
                    }
                  },
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width *0.6, minHeight: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  fillColor: (widget.saldo - total < 0) ? Color(0XFF382A75) : Colors.teal,
                  child: Text((widget.saldo - total < 0) ? 'Top Up My Wallet':'Checkout Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

