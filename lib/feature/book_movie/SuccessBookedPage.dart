import 'package:flutter/material.dart';

import '../../model/BookedMovieModel.dart';
import '../../model/ChooseDateModel.dart';
import '../../model/HistoryTransactions.dart';
import '../../model/MovieModel.dart';
import '../../model/SeatModel.dart';
import '../../model/TimeModel.dart';
import '../../model/User.dart';
import '../main_menu/view/MainMenuPage.dart';

class SuccessBookedPage extends StatefulWidget {
  final TabController tabController;
  final User user;
  final MovieModel movie;
  final double newSaldoTotal;
  final ChooseDateModel date;
  final TimeModel venueAndTime;
  final List<SeatModel> choosenSeats;
  final List<BookedMovieModel> bookedMovieHistory;
  final List<HistoryTransactions> historyTransaction;
  const SuccessBookedPage({Key? key, required this.movie, required this.newSaldoTotal, required this.date, required this.venueAndTime, required this.choosenSeats, required this.user, required this.tabController, required this.bookedMovieHistory, required this.historyTransaction}) : super(key: key);

  @override
  State<SuccessBookedPage> createState() => _SuccessBookedPageState();
}

class _SuccessBookedPageState extends State<SuccessBookedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/successBook.jpeg',
                height: 110,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 60,),
              Text('Happy Watching!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
              SizedBox(height: 20,),
              Text('You have successfully \nbought the ticket',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
              SizedBox(height: 50,),
              RawMaterialButton(
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainMenuPage(user: widget.user, newSaldo: widget.newSaldoTotal, tabController: widget.tabController, newBookedMovieHistory: widget.bookedMovieHistory, newHistoryTransactions: widget.historyTransaction,)), (route) => false);
                },
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, minHeight: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                fillColor: Color(0XFF382A75),
                child: Text('My Tickets', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Discover new movie?', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 14)),
                  SizedBox(width: 8),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainMenuPage(user: widget.user, newSaldo: widget.newSaldoTotal, newBookedMovieHistory: widget.bookedMovieHistory, newHistoryTransactions: widget.historyTransaction,)),(route) => false);
                      },
                      child: Text('Back to Home', style: TextStyle(color: Color(0XFF382A75), fontWeight: FontWeight.w300, fontSize: 14))
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
