import 'dart:convert';

import 'package:flutix_app/feature/splash_screen/view/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/User.dart';
import '../../main_menu/view/MainMenuPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode emailFocusNode = FocusNode(); //buat ngontrol warna label text email, biar ga kuning terus
  FocusNode passwordFocusNode = FocusNode(); //buat ngontrol warna label text password, biar ga kuning terus
  TextEditingController emailController = TextEditingController(); //controller text email => biar program tau apa yang diinput user
  TextEditingController passwordController = TextEditingController(); //controller text password => biar program tau apa yang diinput user

  bool validEmail = false;
  bool passwordLengthMoreThan5 = false;

  checkAccount() async {
    final prefs = await SharedPreferences.getInstance();
    var listUserString = prefs.getStringList('listUser');

    if(listUserString == null){
      return;
    }
    else{
      List<User> users = [];
      listUserString.forEach((user) {
        var temp = User.fromJson(json.decode(user));
        users.add(temp);
      });

      User existUser = User();
      try{
        existUser = users.singleWhere((user) => user.email == emailController.text);
      }
      catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Email or Password"),
          elevation: 0,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0XFFFE5981),
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 78),
        ));
      }

      if(existUser.email == emailController.text && existUser.password == passwordController.text){
        return existUser;
      }
      else{
       return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/logoIcon.jpg',
                scale: 5,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 80,
              ),
              Text('Welcome Back, \nExplorer!', style: TextStyle(color: Color(0XFF262626),fontSize: 20,fontWeight: FontWeight.w300)),

              SizedBox(height: 40,),

              TextFormField(
                onChanged: (value){
                  // https://stackoverflow.com/questions/72698078/how-to-validate-email-after-in-flutter
                  validEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
                  setState(() {}); //refresh
                },
                controller: emailController,
                focusNode: emailFocusNode,
                onTap: (){
                  setState(() {
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFF0D27F)),
                  ),
                  labelText: 'Email Addresss',
                  labelStyle: TextStyle(color: emailFocusNode.hasFocus ? Color(0XFFEDD27F) : Color(0XFF6F6F6F)),
                  hintText: 'Email Address',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                focusNode: passwordFocusNode,
                onChanged: (value){
                  if(value.length > 5){
                    passwordLengthMoreThan5 = true;
                  }
                  else{
                    passwordLengthMoreThan5 = false;
                  }
                  setState(() {}); //refresh
                },
                onTap: (){
                  setState(() {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFA1A1A1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0XFFF0D27F)),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: passwordFocusNode.hasFocus ? Color(0XFFEDD27F) : Color(0XFF6F6F6F)),
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('Forgot Password?', style: TextStyle(color: Color(0XFFAEAEAE), fontSize: 12),),
                  SizedBox(width: 4,),
                  Text('Get Now', style: TextStyle(color: Color(0XFF4F3E9C), fontSize: 12),)
                ],
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async{
                      var existUser = await checkAccount();
                      if(existUser == null){ //fail
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid Email or Password"),
                          elevation: 0,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0XFFFE5981),
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 78),
                        ));
                      }
                      else{
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainMenuPage(user: existUser, newSaldo: existUser.saldo, tabController: null, newBookedMovieHistory: [], newHistoryTransactions: [],)), (route) => false);
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: validEmail && passwordLengthMoreThan5 ? Color(0XFF4F3E9C) : Color(0XFFE4E4E4),
                      minRadius: 25,
                      child: Icon(Icons.arrow_forward, color: validEmail && passwordLengthMoreThan5 ? Colors.white : Color(0XFFC0C0C0)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text('Start Fresh Now?', style: TextStyle(color: Color(0XFFAEAEAE), fontSize: 14),),
                  SizedBox(width: 4,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignUpPage()), (route) => false);
                    },
                      child: Text('Sign Up', style: TextStyle(color: Color(0XFF4F3E9C), fontSize: 14),)
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
