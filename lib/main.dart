import 'dart:convert';

import 'package:flutix_app/feature/splash_screen/view/SignUp.dart';
import 'package:flutix_app/model/BookedMovieModel.dart';
import 'package:flutix_app/model/HistoryTransactions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/main_menu/view/MainMenuPage.dart';
import 'feature/splash_screen/view/SplashScreen.dart';
import 'model/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    authentication();
  }

  authentication()async{
    var prefs = await SharedPreferences.getInstance();
      if(prefs.getString('name') != null ){
        String name = prefs.getString('name')!;
        String email = prefs.getString('email')!;
        String password = prefs.getString('password')!;
        double saldo = double.parse(prefs.getString('saldo')!);
        User user = User(
          name: name,
          email: email,
          password: password
        );
        List<HistoryTransactions> historyTransactions = [];
        var tempHistory = prefs.getStringList('historyTrn');
        if(tempHistory != null){
          tempHistory.forEach((element) {
            historyTransactions.add(HistoryTransactions.fromJson(json.decode(element)));
          });
        }

        // List<BookedMovieModel> bookedMovies = [];
        // var tempBookedMovies = prefs.getStringList('bookedMovies');
        // if(tempBookedMovies != null){
        //   tempBookedMovies.forEach((element) {
        //     bookedMovies.add(BookedMovieModel.fromJson(json.decode(element)));
        //   });
        // }
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainMenuPage(user: user, newSaldo: saldo, tabController: null, newBookedMovieHistory: [], newHistoryTransactions: historyTransactions,)), (route) => false);
      }
      else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignUpPage()), (route) => false);
      }

  }


  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
