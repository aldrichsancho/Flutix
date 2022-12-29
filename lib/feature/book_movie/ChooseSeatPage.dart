import 'package:flutix_app/model/ChooseDateModel.dart';
import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutix_app/model/TimeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../model/BookedMovieModel.dart';
import '../../model/HistoryTransactions.dart';
import '../../model/SeatModel.dart';
import '../../model/User.dart';
import 'CheckoutMoviePage.dart';

class ChooseSeatPage extends StatefulWidget {
  final TabController tabController;
  final User user;
  final MovieModel movie;
  final double saldo;
  final ChooseDateModel date;
  final TimeModel venueAndTime;
  final List<BookedMovieModel> bookedMovieHistory;
  final List<HistoryTransactions> historyTransaction;
  const ChooseSeatPage({Key? key, required this.movie, required this.saldo, required this.date, required this.venueAndTime, required this.user, required this.tabController, required this.bookedMovieHistory, required this.historyTransaction}) : super(key: key);

  @override
  State<ChooseSeatPage> createState() => _ChooseSeatPageState();
}

class _ChooseSeatPageState extends State<ChooseSeatPage> {
  bool alreadyChoose = false;
  List<SeatModel> seats = [];
  @override
  void initState() {
    autoFillSeatNumber();
    super.initState();

  }
  List<int> totalSeatInRow = [3,5,5,5,5];
  List<String> seatNumbers = ["A","B","C","D","E"];
  autoFillSeatNumber(){
    for(var i = 4; i >= 0; i--){ //dilooping terbalik agar E1 berada paling depan (hal ini perlu diperhatikan karena kita menggunakan konsep gridview reverse), jika tidak dilooping terbalik maka E5 akan berada pada paling depan
        for(var j = 1; j < totalSeatInRow[i]+1; j++){
          seats.add(SeatModel(number: '${seatNumbers[i]}${j}', isSelected: false, booked: false));
      }
    }

    seats.forEach((element) {
      if(element.number.contains('1')){
        element.booked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,60,20,20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.arrow_back)
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text('${widget.movie.title}', textAlign: TextAlign.right, style: TextStyle(fontSize: 20,color: Color(0XFF262626), fontWeight: FontWeight.w300),)),
                    SizedBox(width: 12,),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("http://image.tmdb.org/t/p/w500${widget.movie.posterPath}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: 30,),
            Container(
              height: 3,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: Color(0XFF4F3E9C),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0XFFFBD45F).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Text('Cinema Screen', style: TextStyle(color: Colors.grey, fontSize: 8, fontWeight: FontWeight.w300),),
            SizedBox(height: 60,),
            Container(
              width: 300,
              child: Wrap(
                verticalDirection: VerticalDirection.up, //reverse
                runSpacing: 14,
                spacing: 14,
                alignment: WrapAlignment.center,
                children: List.generate(seats.length, (i) {
                  return InkWell(
                    onTap: (){
                      if(seats[i].booked){
                        seats[i].isSelected = false;
                      }
                      else{
                        seats[i].isSelected = !seats[i].isSelected;
                        if(seats[i].isSelected){
                          alreadyChoose = true;
                        }
                      }

                      setState(() {});
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: seats[i].booked ? Color(0XFFE4E4E4) : seats[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: seats[i].booked ? Color(0XFFE4E4E4) : seats[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                      ),
                      child: Center(child: Text('${seats[i].number}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: 275,
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0XFFE4E4E4)),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text('Available', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey),)
                    ],
                  ),
                  SizedBox(width: 20,),
                  Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color(0XFFE4E4E4),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0XFFE4E4E4)),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text('Booked', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey),)
                    ],
                  ),
                  SizedBox(width: 20,),
                  Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color(0XFFFBD45F),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0XFFFBD45F)),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text('Selected', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey),)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    var choosenSeat = seats.where((element) => element.isSelected).toList();
                    if(choosenSeat.length > 0){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutMoviePage(user: widget.user, saldo: widget.saldo, movie: widget.movie, date: widget.date, venueAndTime: widget.venueAndTime, choosenSeats: choosenSeat, tabController: widget.tabController,bookedMovieHistory: widget.bookedMovieHistory, historyTransaction: widget.historyTransaction)));
                    }

                  },
                  child: CircleAvatar(
                    backgroundColor:  alreadyChoose ? Color(0XFF4F3E9C) : Color(0XFFE4E4E4),
                    minRadius: 25,
                    child: Icon(Icons.arrow_forward, color: alreadyChoose? Colors.white : Color(0XFFC0C0C0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
