import 'package:flutix_app/model/ChooseDateModel.dart';
import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutix_app/model/TimeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChooseVenuePage extends StatefulWidget {
  final MovieModel movie;
  final double saldo;
  const ChooseVenuePage({Key? key, required this.movie, required this.saldo}) : super(key: key);

  @override
  State<ChooseVenuePage> createState() => _ChooseVenuePageState();
}

class _ChooseVenuePageState extends State<ChooseVenuePage> {
  bool atLeastOnePlaceSelected = false;
  List<DateTime> days = [];
  List<ChooseDateModel> dateModel = [];
  List<TimeModel> paskalTimes = [
    TimeModel(time: '10:00', isSelected: false),
    TimeModel(time: '12:00', isSelected: false),
    TimeModel(time: '14:00', isSelected: false),
    TimeModel(time: '16:00', isSelected: false),
    TimeModel(time: '18:00', isSelected: false),
    TimeModel(time: '20:00', isSelected: false),
    TimeModel(time: '22:00', isSelected: false),
  ];

  List<TimeModel> pvjTimes = [
    TimeModel(time: '10:00', isSelected: false),
    TimeModel(time: '12:00', isSelected: false),
    TimeModel(time: '14:00', isSelected: false),
    TimeModel(time: '16:00', isSelected: false),
    TimeModel(time: '18:00', isSelected: false),
    TimeModel(time: '20:00', isSelected: false),
    TimeModel(time: '22:00', isSelected: false),
  ];

  List<TimeModel> ciwalkTimes = [
    TimeModel(time: '10:00', isSelected: false),
    TimeModel(time: '12:00', isSelected: false),
    TimeModel(time: '14:00', isSelected: false),
    TimeModel(time: '16:00', isSelected: false),
    TimeModel(time: '18:00', isSelected: false),
    TimeModel(time: '20:00', isSelected: false),
    TimeModel(time: '22:00', isSelected: false),
  ];

  List<TimeModel> btcTimes = [
    TimeModel(time: '10:00', isSelected: false),
    TimeModel(time: '12:00', isSelected: false),
    TimeModel(time: '14:00', isSelected: false),
    TimeModel(time: '16:00', isSelected: false),
    TimeModel(time: '18:00', isSelected: false),
    TimeModel(time: '20:00', isSelected: false),
    TimeModel(time: '22:00', isSelected: false),
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
                    for(var i = 0; i < paskalTimes.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: (){
                            //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                            for(var j = 0; j < 7; j++){
                              paskalTimes[j].isSelected = false;
                              pvjTimes[j].isSelected = false;
                              ciwalkTimes[j].isSelected = false;
                              btcTimes[j].isSelected = false;
                            }
                            paskalTimes[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                            atLeastOnePlaceSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            width: 140,
                            decoration: BoxDecoration(
                              color: paskalTimes[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: paskalTimes[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                            ),
                            child: Center(child: Text('${paskalTimes[i].time}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
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
                    for(var i = 0; i < pvjTimes.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: (){
                            //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                            for(var j = 0; j < 7; j++){
                              paskalTimes[j].isSelected = false;
                              pvjTimes[j].isSelected = false;
                              ciwalkTimes[j].isSelected = false;
                              btcTimes[j].isSelected = false;
                            }

                            pvjTimes[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                            atLeastOnePlaceSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            width: 140,
                            decoration: BoxDecoration(
                              color: pvjTimes[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: pvjTimes[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                            ),
                            child: Center(child: Text('${pvjTimes[i].time}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
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
                    for(var i = 0; i < ciwalkTimes.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: (){
                            //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                            for(var j = 0; j < 7; j++){
                              paskalTimes[j].isSelected = false;
                              pvjTimes[j].isSelected = false;
                              ciwalkTimes[j].isSelected = false;
                              btcTimes[j].isSelected = false;
                            }

                            ciwalkTimes[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                            atLeastOnePlaceSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            width: 140,
                            decoration: BoxDecoration(
                              color: ciwalkTimes[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: ciwalkTimes[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                            ),
                            child: Center(child: Text('${ciwalkTimes[i].time}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
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
                    for(var i = 0; i < btcTimes.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: (){
                            //konsep : ubah semua isSelected  jadi false dan isi language yang terpilih jadi true
                            for(var j = 0; j < 7; j++){
                              paskalTimes[j].isSelected = false;
                              pvjTimes[j].isSelected = false;
                              ciwalkTimes[j].isSelected = false;
                              btcTimes[j].isSelected = false;
                            }

                            btcTimes[i].isSelected = true; //ini diassign true dan tidak ada ! karena dicontoh flutix jika yg udah keselect dipencet maka tidak akan hilang
                            atLeastOnePlaceSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            width: 140,
                            decoration: BoxDecoration(
                              color: btcTimes[i].isSelected ? Color(0XFFFBD45F) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: btcTimes[i].isSelected ? Color(0XFFFBD45F) :  Color(0XFFE7E7E7)),
                            ),
                            child: Center(child: Text('${btcTimes[i].time}',textAlign: TextAlign.center, style: TextStyle(color: Color(0XFF262626), fontWeight: FontWeight.w400, fontSize: 14),)),
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
                    onTap: (){},
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
