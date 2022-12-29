import 'package:flutix_app/model/BookedMovieModel.dart';
import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/User.dart';

class TicketDetailPage extends StatefulWidget {
  final BookedMovieModel ticket;
  final User user;
  const TicketDetailPage({Key? key, required this.ticket, required this.user}) : super(key: key);

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  String seatNumbers = '';

  @override
  void initState() {
    getSeatNumbers();
    super.initState();

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

  String moneyFormat(double amount) {
    if (amount == null) return '0';
    return NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
        .format(amount);
  }

  leftRightComponent(String textLeft, String textRight){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.5 - 40,
            child: Text(textLeft, style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),)
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.5 - 40,
            child: Text(textRight, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight:FontWeight.w300),textAlign: TextAlign.right,)
        ),
      ],
    );
  }

  getSeatNumbers(){
    for(var i = 0; i < widget.ticket.seat.length; i++){
      if(i+1 != widget.ticket.seat.length){
        seatNumbers += '${widget.ticket.seat[i].number}, ';
      }
      else{
        seatNumbers += '${widget.ticket.seat[i].number}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0XFFF4F4F4),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0XFF262626),
        ),
        title: Text('Ticket Details', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24, color: Color(0XFF262626))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Column(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage("http://image.tmdb.org/t/p/w500${widget.ticket.movie.posterPath}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.ticket.movie.title}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          for(var i = 0; i < widget.ticket.movie.genres!.length; i++)
                            Text('${widget.ticket.movie.genres![i].name}${i == widget.ticket.movie.genres!.length-1 ? '': ', '}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                            ),

                          Text(' - ${widget.ticket.movie.lang!.first.name}',// ambil list "lang" yang pertama
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          Row(
                            children: getStar(widget.ticket.movie), //karena return dari fungsi sudah list maka tidak perlu tnda []
                          ),
                          Row(
                            children: [
                              SizedBox(width: 3,),
                              Text('${widget.ticket.movie.voteAverage!.toStringAsFixed(1)}/10', style: TextStyle(color: Colors.grey, fontSize: 12),)

                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 12,),
                      leftRightComponent('Cinema', '${widget.ticket.timeAndVenue.venue}'),
                      SizedBox(height: 12,),
                      leftRightComponent('Date & Time', '${widget.ticket.date.name} ${widget.ticket.date.day} ${widget.ticket.timeAndVenue.time}'),
                      SizedBox(height: 12,),
                      leftRightComponent('Seat Number', '${seatNumbers}'),
                      SizedBox(height: 12,),
                      leftRightComponent('Order Id', 'OKD4320JNJ734'),
                      SizedBox(height: 24,),
                      MySeparator(),
                      SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama:', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),),
                              SizedBox(height: 4,),
                              Text('${widget.user.name}', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),),
                              SizedBox(height: 8,),
                              Text('Paid:', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),),
                              SizedBox(height: 4,),
                              Text('Rp ${moneyFormat(widget.ticket.total)}', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),)
                            ],
                          ),
                          Image.asset(
                           'assets/barcode.png',
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1})
      : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey[400]),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}