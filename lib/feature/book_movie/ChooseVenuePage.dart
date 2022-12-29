import 'package:flutix_app/feature/book_movie/ChooseSeatPage.dart';
import 'package:flutix_app/model/ChooseDateModel.dart';
import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutix_app/model/TimeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/BookedMovieModel.dart';
import '../../model/HistoryTransactions.dart';
import '../../model/User.dart';

class ChooseVenuePage extends StatefulWidget {
  final TabController tabController;
  final User user;
  final MovieModel movie;
  final double saldo;
  final List<BookedMovieModel> bookedMovieHistory;
  final List<HistoryTransactions> historyTransaction;
  const ChooseVenuePage({Key? key, required this.movie, required this.saldo, required this.user, required this.tabController, required this.bookedMovieHistory, required this.historyTransaction}) : super(key: key);

  @override
  State<ChooseVenuePage> createState() => _ChooseVenuePageState();
}

class _ChooseVenuePageState extends State<ChooseVenuePage> {
  bool atLeastOnePlaceSelected = false;
  List<DateTime> days = [];
  List<ChooseDateModel> dateModel = [];

  List<TimeModel> venueAndTimes = [
    TimeModel(time: '10:00', isSelected: false, venue: 'CGV 23 Paskal Hyper Square'),
    TimeModel(time: '12:00', isSelected: false, venue: 'CGV 23 Paskal Hyper Square'),
    TimeModel(time: '14:00', isSelected: false, venue: 'CGV 23 Paskal Hyper Square'),
    TimeModel(time: '16:00', isSelected: false, venue: 'CGV 23 Paskal Hyper Square'),
    TimeModel(time: '18:00', isSelected: false, venue: 'CGV 23 Paskal Hyper Square'),
    TimeModel(time: '20:00', isSelected: false, venue: 'CGV 23 Paskal Hyper Square'),
    TimeModel(time: '22:00', isSelected: false, venue: 'CGV 23 Paskal Hyper Square'),
    TimeModel(time: '10:00', isSelected: false, venue: 'CGV Paris Van Java'),
    TimeModel(time: '12:00', isSelected: false, venue: 'CGV Paris Van Java'),
    TimeModel(time: '14:00', isSelected: false, venue: 'CGV Paris Van Java'),
    TimeModel(time: '16:00', isSelected: false, venue: 'CGV Paris Van Java'),
    TimeModel(time: '18:00', isSelected: false, venue: 'CGV Paris Van Java'),
    TimeModel(time: '20:00', isSelected: false, venue: 'CGV Paris Van Java'),
    TimeModel(time: '22:00', isSelected: false, venue: 'CGV Paris Van Java'),
    TimeModel(time: '10:00', isSelected: false, venue: 'XXI Cihampelas Walk'),
    TimeModel(time: '12:00', isSelected: false, venue: 'XXI Cihampelas Walk'),
    TimeModel(time: '14:00', isSelected: false, venue: 'XXI Cihampelas Walk'),
    TimeModel(time: '16:00', isSelected: false, venue: 'XXI Cihampelas Walk'),
    TimeModel(time: '18:00', isSelected: false, venue: 'XXI Cihampelas Walk'),
    TimeModel(time: '20:00', isSelected: false, venue: 'XXI Cihampelas Walk'),
    TimeModel(time: '22:00', isSelected: false, venue: 'XXI Cihampelas Walk'),
    TimeModel(time: '10:00', isSelected: false, venue: 'XXI Bandung Trade Center'),
    TimeModel(time: '12:00', isSelected: false, venue: 'XXI Bandung Trade Center'),
    TimeModel(time: '14:00', isSelected: false, venue: 'XXI Bandung Trade Center'),
    TimeModel(time: '16:00', isSelected: false, venue: 'XXI Bandung Trade Center'),
    TimeModel(time: '18:00', isSelected: false, venue: 'XXI Bandung Trade Center'),
    TimeModel(time: '20:00', isSelected: false, venue: 'XXI Bandung Trade Center'),
    TimeModel(time: '22:00', isSelected: false, venue: 'XXI Bandung Trade Center'),
  ];


  @override
  void initState() {
    getDayOfTheWeek();
    super.initState();

  }

  getDayOfTheWeek(){
    for(var i = 0; i < 7; i++){
      days.add(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+i));
    }

    for(var i = 0; i < days.length; i++) {
      dateModel.add(ChooseDateModel(name: DateFormat('EEE').format(days[i]), day: days[i].day, isSelected: i == 0 ? true : false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0XFF262626),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose Date', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(var i = 0; i < dateModel.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: InkWell(
                        onTap: (){
                          //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                          for(var j = 0; j < dateModel.length; j++){
                            dateModel[j].isSelected = false;
                          }
                          dateModel[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          width: 70,
                          decoration: BoxDecoration(
                            color: dateModel[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: dateModel[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                          ),
                          child: Center(child: Column(
                            children: [
                              Text('${dateModel[i].name}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w300, fontSize: 16),),
                              SizedBox(height: 15,),
                              Text('${dateModel[i].day}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w300, fontSize: 16),)
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Text('CGV 23 Paskal Hyper Square', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
              SizedBox(height: 16,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(var i = 0; i < 7; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: (){
                            //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                            for(var j = 0; j < venueAndTimes.length; j++){
                              venueAndTimes[j].isSelected = false;
                            }
                            venueAndTimes[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                            atLeastOnePlaceSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            width: 140,
                            decoration: BoxDecoration(
                              color: venueAndTimes[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: venueAndTimes[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                            ),
                            child: Center(child: Text('${venueAndTimes[i].time}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Text('CGV Paris Van Java', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
              SizedBox(height: 16,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(var i = 7; i < 14; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: (){
                            //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                            for(var j = 0; j < venueAndTimes.length; j++){
                              venueAndTimes[j].isSelected = false;
                            }

                            venueAndTimes[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                            atLeastOnePlaceSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            width: 140,
                            decoration: BoxDecoration(
                              color: venueAndTimes[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: venueAndTimes[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                            ),
                            child: Center(child: Text('${venueAndTimes[i].time}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Text('XXI Cihampelas Walk', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
              SizedBox(height: 16,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(var i = 14; i < 21; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: (){
                            //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                            for(var j = 0; j < venueAndTimes.length; j++){
                              venueAndTimes[j].isSelected = false;
                            }

                            venueAndTimes[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                            atLeastOnePlaceSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            width: 140,
                            decoration: BoxDecoration(
                              color: venueAndTimes[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: venueAndTimes[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                            ),
                            child: Center(child: Text('${venueAndTimes[i].time}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Text('XXI Bandung Trade Center', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
              SizedBox(height: 16,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(var i = 21; i < 28; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: (){
                            //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                            for(var j = 0; j < venueAndTimes.length; j++){
                              venueAndTimes[j].isSelected = false;
                            }

                            venueAndTimes[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                            atLeastOnePlaceSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            width: 140,
                            decoration: BoxDecoration(
                              color: venueAndTimes[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: venueAndTimes[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                            ),
                            child: Center(child: Text('${venueAndTimes[i].time}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      var choosenDate;
                      var choosenVenueAndTime;
                      dateModel.forEach((dateModel) {
                        if(dateModel.isSelected){
                          choosenDate = dateModel;
                        }
                      });
                      venueAndTimes.forEach((venueAndTime) {
                        if(venueAndTime.isSelected){
                          choosenVenueAndTime = venueAndTime;
                        }
                      });

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseSeatPage(user: widget.user ,movie: widget.movie, saldo: widget.saldo, date: choosenDate, venueAndTime: choosenVenueAndTime,tabController: widget.tabController, bookedMovieHistory: widget.bookedMovieHistory, historyTransaction: widget.historyTransaction)));
                    },
                    child: CircleAvatar(
                      backgroundColor:  atLeastOnePlaceSelected ? Color(0XFF4F3E9C) : Color(0XFFE4E4E4),
                      minRadius: 25,
                      child: Icon(Icons.arrow_forward, color: atLeastOnePlaceSelected? Colors.white : Color(0XFFC0C0C0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
