
import 'package:flutter/material.dart';

import 'Login.dart';
import 'SignUp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: MediaQuery.of(context).size.height - 200,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //agar tampilan ke centered vertically
            children: [
              Image.asset(
                'assets/logoIcon.jpg',
                scale: 2.8,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 70,
              ),
              Text('New Experience',
                  style: TextStyle(
                      color: Color(0XFF262626),
                      fontSize: 20,
                      fontWeight: FontWeight.w300)),
              SizedBox(
                height: 20,
              ),
              Text(
                'Watch a new movie much \n easier than any before',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0XFFACACAC),
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 70,
              ),
              RawMaterialButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
                },
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, minHeight: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                fillColor: Color(0XFF4F3E9C),
                child: Text('Get Started', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?', style: TextStyle(color: Color(0XFFACACAC), fontSize: 14, fontWeight: FontWeight.w300),), 
                  SizedBox(width: 4,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: Text('Sign In', style: TextStyle(color: Color(0XFF4F3E9C), fontSize: 14, fontWeight: FontWeight.w300),)
                  )
                  ],
              )
            ]),
      )),
    );
  }
}
