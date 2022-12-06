import 'dart:convert';

import 'package:flutix_app/feature/main_menu/view/TopUpPage.dart';
import 'package:flutix_app/model/CategoryModel.dart';
import 'package:flutix_app/model/MovieModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../model/User.dart';
import '../../../model/VoucherModel.dart';

class MainMenuPage extends StatefulWidget {
  final User user;
  const MainMenuPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> with SingleTickerProviderStateMixin {
  double saldo = 50000;
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
  @override
  void initState() {
    getDataMovieAPI();
    super.initState();

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
    setState(() { });

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

  newMoviesComponent(){
    return SingleChildScrollView(
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
                    Container(
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
                    SizedBox(width: 12,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.user.name}', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
                        SizedBox(height: 4,),
                        Text('IDR ${moneyFormat(saldo)}', style: TextStyle(color: Color(0XFFFBD361), fontSize: 15, fontWeight: FontWeight.w400),)
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
                                return Padding(
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
    );
  }
  myTicketsComponent(){
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0XFF2C1F64),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20,40,20,0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('My Tickets', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300)),
                          TabBar(
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
                        ],
                      ),
                    ),
                  ),

                ],
              )
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
          body: TabBarView(
            children: [
              newMoviesComponent(),
              myTicketsComponent()
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //ini pakai async await untuk nunggu dlu hasil return dari TopUpPage, lalu dicek apakah null atau tidak
              //kalau tidak null (terdapat nominal topup/ melakukan topup) maka saldo akan bertambah
              //result berupa double
              var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => TopUpPage()));
              if(result != null){
                setState(() {
                  saldo += result;
                });
              }
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