import 'dart:convert';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutix_app/feature/book_movie/DetailMoviePage.dart';
import 'package:flutix_app/feature/book_movie/TicketDetailPage.dart';
import 'package:flutix_app/feature/main_menu/view/TopUpPage.dart';
import 'package:flutix_app/model/BookedMovieModel.dart';
import 'package:flutix_app/model/CategoryModel.dart';
import 'package:flutix_app/model/HistoryTransactions.dart';
import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/User.dart';
import '../../../model/VoucherModel.dart';
import '../../my_wallet/MyWalletPage.dart';
import '../../profile_account/AccountPage.dart';

class MainMenuPage extends StatefulWidget {
  final User user;
  final TabController? tabController;
  final double? newSaldo;
  final List<HistoryTransactions>? newHistoryTransactions;
  final List<BookedMovieModel>? newBookedMovieHistory;
  const MainMenuPage({Key? key, required this.user, this.newSaldo, this.newHistoryTransactions, this.tabController, this.newBookedMovieHistory}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> with SingleTickerProviderStateMixin {
  double saldo = 50000;
  TabController? _tabController;

  String moneyFormat(double amount) {
    if (amount == null) return '0';
    return NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
        .format(amount);
  }
  List<CategoryModel> categories = [
    CategoryModel(iconUrl: 'assets/horror.png', title: 'Horror'),
    CategoryModel(iconUrl: 'assets/action.png', title: 'Action'),
    CategoryModel(iconUrl: 'assets/drama.png', title: 'Drama'),
    CategoryModel(iconUrl: 'assets/crime.png', title: 'Crime'),
  ];

  List<VoucherModel> vouchers = [
    VoucherModel(title: 'Student Holiday',subtitle: 'Maximal only for two people',discount: 50),
    VoucherModel(title: 'Family CLub',subtitle: 'Minimal for three members',discount: 70),
    VoucherModel(title: 'Subscription Promo',subtitle: 'Min. one year',discount: 40),
  ];
  List<MovieModel> movies = [];
  List<MovieModel> comingSoonmovies = [];

  List<HistoryTransactions> history = [];
  List<BookedMovieModel> bookedMovieHistory = [];

  @override
  void initState() {
    if(widget.newSaldo != null){
     saldo = widget.newSaldo!;
    }
    if(widget.newHistoryTransactions != null){
      for (var element in widget.newHistoryTransactions!) {
        history.add(element);
      }
    }
    if(widget.newBookedMovieHistory != null){
      for (var newBookedMovie in widget.newBookedMovieHistory!) {
        bookedMovieHistory.add(newBookedMovie);
      }
    }
    getDataMovieAPI();
    if(widget.tabController == null){
      _tabController = TabController(vsync: this, length: 2);
    }
    else{
      widget.tabController!.animateTo(1);
    }

    saveData();
    super.initState();

  }

  saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('saldo', '${saldo}');

    List<User> users = [];
    var listUserString = prefs.getStringList('listUser');
    listUserString!.forEach((user) {
      var temp = User.fromJson(json.decode(user));
      users.add(temp);
    });

    User existUser = users.singleWhere((user) => user.email == widget.user.email);

    users.forEach((element) {
      if(existUser.email == element.email){
        element.saldo = saldo;
      }
    });
    //
    List<String> userString = [];
    users.forEach((user){
      userString.add(json.encode(user));
    });
    prefs.setStringList('listUser', userString);

    var a = prefs.getStringList('listUser');
    // var temp = json.encode(existUser);
    // prefs.r


    List<String> historyTransactions = [];
    history.forEach((element) {
      historyTransactions.add(json.encode(element)); //ubah model menjadi bentuk string agar bisa disimpan
    });
    // List<String> bookedMovies = [];
    // bookedMovieHistory.forEach((element) {
    //   bookedMovies.add(json.encode(element)); //ubah model menjadi bentuk string agar bisa disimpan
    // });
    //
    prefs.setStringList('historyTrn', historyTransactions);
    // prefs.setStringList('bookedMovies',bookedMovies);

  }

  getDataMovieAPI() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/movie/day?api_key=d3c370e7fe51dfcd86bd698f8a3b8b32'));
    if(response.statusCode == 200){
      movies.clear(); //diclear dlu biar ga double
      List list = json.decode(response.body)['results'];
      list.forEach((element) {
        movies.add(MovieModel.fromJson(element));
      });
    }
    else{
      print(response.body);
    }

    final responseComingSoon = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=d3c370e7fe51dfcd86bd698f8a3b8b32&language=en-US&page=1'));
    if(responseComingSoon.statusCode == 200){
      comingSoonmovies.clear(); //diclear dlu biar ga double
      List list = json.decode(responseComingSoon.body)['results'];
      list.forEach((element) {
        comingSoonmovies.add(MovieModel.fromJson(element));
      });
    }
    else{
      print(response.body);
    }

    setState(() {

    });
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

  newestHistory(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for(var i = 0; i < bookedMovieHistory.length; i++)
              if(bookedMovieHistory[i].date.day >= DateTime.now().day)
                // if(int.parse(bookedMovieHistory[i].timeAndVenue.time.substring(0,2)) >= DateTime.now().hour)
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicketDetailPage(ticket: bookedMovieHistory[i], user: widget.user)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage("http://image.tmdb.org/t/p/w500${bookedMovieHistory[i].movie.posterPath}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${bookedMovieHistory[i].movie.title}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                          SizedBox(height: 6,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for(var j = 0; j < bookedMovieHistory[i].movie.genres!.length; j++)
                                Text('${bookedMovieHistory[i].movie.genres![j].name}${j == bookedMovieHistory[i].movie.genres!.length-1 ? '': ', '}',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                                ),

                              Text(' - ${bookedMovieHistory[i].movie.lang!.first.name}',// ambil list "lang" yang pertama
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 6,),
                          Text('${bookedMovieHistory[i].timeAndVenue.venue}',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  oldestHistory(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for(var i = 0; i < bookedMovieHistory.length; i++)
              if(bookedMovieHistory[i].date.day <= DateTime.now().day)
                // if(int.parse(bookedMovieHistory[i].timeAndVenue.time.substring(0,2)) <= DateTime.now().hour)
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicketDetailPage(ticket: bookedMovieHistory[i], user: widget.user)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 90,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage("http://image.tmdb.org/t/p/w500${bookedMovieHistory[i].movie.posterPath}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${bookedMovieHistory[i].movie.title}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                              SizedBox(height: 6,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for(var j = 0; j < bookedMovieHistory[i].movie.genres!.length; j++)
                                    Text('${bookedMovieHistory[i].movie.genres![j].name}${j == bookedMovieHistory[i].movie.genres!.length-1 ? '': ', '}',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                                    ),

                                  Text(' - ${bookedMovieHistory[i].movie.lang!.first.name}',// ambil list "lang" yang pertama
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6,),
                              Text('${bookedMovieHistory[i].timeAndVenue.venue}',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  newMoviesComponent(){
    return DoubleBackToCloseApp(
      snackBar: const SnackBar(
        content: Text('Tap sekali lagi untuk keluar'),
      ),
      child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0XFF2C1F64),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,40,20,20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPage(user: widget.user, saldo: saldo,history: history,)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0XFFFBD361).withOpacity(0.2)),
                              shape: BoxShape.circle
                          ),
                          child: widget.user.photoProfile != null ?
                          CircleAvatar(backgroundImage: FileImage( widget.user.photoProfile!), radius: 25.0,)
                              :
                          Image.asset(
                            'assets/user.png',
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(width: 12,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.user.name}', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
                          SizedBox(height: 4,),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWalletPage(user: widget.user, saldo: saldo,historyTransactions: history,)));
                            },
                            child: Text('IDR ${moneyFormat(saldo)}', style: TextStyle(color: Color(0XFFFBD361), fontSize: 15, fontWeight: FontWeight.w400),)
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Now Playing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 140,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: movies.length,
                                itemBuilder: (context, i){
                                  return InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailMoviePage(movie: movies[i], saldo: saldo,user: widget.user, tabController: _tabController ?? widget.tabController!, bookedMovieHistory: bookedMovieHistory, historyTransaction: history)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: Stack(
                                        children: [

                                          Container(
                                            width: 220,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                image: DecorationImage(
                                                  image: NetworkImage("http://image.tmdb.org/t/p/w500${movies[i].posterPath}"),
                                                  fit: BoxFit.cover,
                                                ),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: <Color>[
                                                      Colors.black.withOpacity(0),
                                                      Colors.black.withOpacity(0.2)
                                                    ])
                                            ),
                                          ),
                                          Container(
                                            width: 220,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: <Color>[
                                                      Colors.black.withOpacity(0),
                                                      Colors.black.withOpacity(0.9)
                                                    ])
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('${movies[i].title}', style: TextStyle(color: Colors.white)),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: getStar(movies[i]), //karena return dari fungsi sudah list maka tidak perlu tnda []
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 3,),
                                                          Text('${movies[i].voteAverage!.toStringAsFixed(1)}/10', style: TextStyle(color: Colors.white),)

                                                        ],
                                                      )
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('Browse Movie', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(var i = 0; i< categories.length; i++)
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0XFFEEF1F8)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    categories[i].iconUrl!,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6,),
                              Text('${categories[i].title!}', style: TextStyle(fontWeight: FontWeight.w300),)
                            ],
                          ),

                      ],
                    ),
                    SizedBox(height: 40),
                    Text('Coming Soon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 160,
                            width: 125,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: comingSoonmovies.length,
                                itemBuilder: (context, i){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Container(
                                      height: 160,
                                      width: 125,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: NetworkImage("http://image.tmdb.org/t/p/w500${comingSoonmovies[i].posterPath}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text('Get Lucky Day', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    SizedBox(height: 12),
                    for(var i = 0; i<vouchers.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color(0XFF4F3E9C)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${vouchers[i].title}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                                  SizedBox(height: 2,),
                                  Text('${vouchers[i].subtitle}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12),),
                                ],
                              ),
                              Text.rich(
                                  TextSpan(
                                      children: [
                                        TextSpan(text: 'OFF ',style: TextStyle(fontSize: 16,color: Color(0XFFFBD361),fontWeight: FontWeight.w400,)),
                                        TextSpan(
                                            text: '${vouchers[i].discount}%',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFFFBD361)
                                            )
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
  myTicketsComponent(){
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0XFF2C1F64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
            title: Text('My Tickets', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300)),
            bottom: TabBar(
              indicatorColor: Color(0XFFF8D560),
              indicatorWeight: 3,
              isScrollable: false,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              labelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              tabs: [
                Tab(child: Text('Newest')),
                Tab(child: Text('Oldest')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              newestHistory(),
              oldestHistory()
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBody: true,
          body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap sekali lagi untuk keluar'),
            ),
            child: TabBarView(
              controller: _tabController ?? widget.tabController,
              children: [
                newMoviesComponent(),
                myTicketsComponent()
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TopUpPage(user: widget.user, saldo: saldo,historyTransactions: history)));
            },
            backgroundColor: Color(0XFFF8D560),
            child:Image.asset('assets/wallet.png', height: 120, ),
            elevation: 2.0,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: menu(),
          ),

        ),
      ),

    );
  }

  Widget menu() {
    return Container(
      child: TabBar(
        controller: _tabController ?? widget.tabController,
        physics: NeverScrollableScrollPhysics(),
        labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        indicatorColor: Colors.transparent,
        labelColor: Color(0XFF4F3E9C),
        unselectedLabelColor: Colors.grey[300],
        indicatorPadding: EdgeInsets.all(5.0),
        tabs: [
          Tab(
            text: "New Movies",
            icon: Icon(Icons.smart_display),
          ),
          Tab(
            text: "My Tickets",
            icon: Icon(Icons.confirmation_number_rounded),
          ),
        ],
      ),
    );
  }
}
